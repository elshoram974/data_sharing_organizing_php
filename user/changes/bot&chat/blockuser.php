<?php

include "../../../connect.php";
$admin_id = postRequest("admin_id");
$user_id = postRequest("user_id");
$group_id = postRequest("group_id");
$direction_id = postRequest("direction_id" , true);
$activity_id = postRequest("activity_id" , true);
$dir =  "../../../assets/groups_files";

$adminstmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$adminstmt->execute(array($admin_id , $group_id));
$adminstatus = $adminstmt->fetchAll(PDO::FETCH_ASSOC);
if ($adminstatus[0]['member_is_admin'] == 0) {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
}

if (empty($direction_id) && empty($activity_id)) {
    $response = errorState(400, 'missing_data', 'Both direction_id and activity_id cannot be empty in same time.');
    echo json_encode($response);
    exit();
}

if(empty($direction_id)){
    $direction_id = NULL;
}elseif(empty($activity_id)){
    $activity_id = NULL;
}

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);
if ($userstatus[0]['member_is_admin'] == 1){
    $response = errorState(403, 'forbidden', 'Cannot block a user who is an admin.');
    echo json_encode($response);
    exit();
}

if(isset($direction_id)){
    $updatestmt = $con->prepare('UPDATE `group_members` SET `member_can_interaction`= ? WHERE `member_id`= ? AND `group_id`= ?');
    $updatestmt->execute(array(0,$user_id,$group_id));
    $count =  $updatestmt->rowCount();
    if($count==0){
	    $response = errorState(500,'db_error','Error blocking the user. Please try again later.');
        echo json_encode($response);
        exit;
    }

    $deletestmt = $con->prepare('DELETE FROM `group_activity_direction` WHERE `direction_id`= ? OR `inside_direction_id`= ?;
                                 DELETE FROM `group activity` WHERE `activity_direction_id`=?;');
    $deletestmt->execute(array($direction_id,$direction_id,$direction_id));
    $count =  $deletestmt->rowCount();
    if($count>0){
        $response = successState('response', ['massege' => 'user was blocked']);
    }else{
	    $response = errorState(500,'db_error','user was blocked but error deleting direction from database. Please try again later.');
    }

    echo json_encode($response);
}


if(isset($activity_id)){
    $updatestmt = $con->prepare('UPDATE `group_members` SET `member_can_interaction`= ? WHERE `member_id`= ? AND `group_id`= ?');
    $updatestmt->execute(array(0,$user_id,$group_id));
    $count =  $updatestmt->rowCount();
    if($count==0){
	    $response = errorState(500,'db_error','Error blocking the user. Please try again later.');
        echo json_encode($response);
        exit;
    }

    $stmt = $con->prepare("SELECT `activity_attachments_url` FROM `group_activity` WHERE  `activity_id`=?");
    $stmt->execute(array($activity_id));
    $activity = $stmt->fetch(PDO::FETCH_ASSOC);
    $deletestmt = $con->prepare('DELETE FROM `group_activity` WHERE `activity_id`= ?');
    $deletestmt->execute(array($activity_id));
    
    $count =  $deletestmt->rowCount();
    
    if($count>0){
        $response = successState('response', ['massege' => 'user was blocked']);
     
        if(isset($activity['activity_attachments_url'])){
            delete_file($dir , end(explode('/', $activity['activity_attachments_url'])));
        }
    }else{
        $response = errorState(500,'db_error','user was blocked but error deleting activity from database. Please try again later.');
    }
    
    echo json_encode($response);
    
}