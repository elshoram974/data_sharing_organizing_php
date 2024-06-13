<?php

include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest("group_id");
$activity_id = postRequest("activity_id");
$dir =  "../../../assets/groups_files";

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);

$state2Stmt = $con->prepare("SELECT activity_owner_id FROM group_activity WHERE activity_id = ? AND activity_group_id = ?");
$state2Stmt->execute(array($activity_id , $group_id));
$owner = $state2Stmt->fetchAll(PDO::FETCH_ASSOC);

if ($userstatus[0]['member_is_admin'] == 0 and $owner[0]['activity_owner_id'] != "$user_id") {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
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
    $response = successState('response', ['massege' => 'activity has been deleted successfully']);
 
    if(isset($activity['activity_attachments_url'])){
        delete_file($dir , end(explode('/', $activity['activity_attachments_url'])));
    }
}else{
	$response = errorState(500,'db_error','Error deleting activity from database. Please try again later.');
}

echo json_encode($response);
