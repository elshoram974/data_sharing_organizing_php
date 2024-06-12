<?php

include "../../../connect.php";
$admin_id = postRequest("admin_id");
$user_id = postRequest("user_id");
$group_id = postRequest("group_id");
$can_interaction = postRequest("can_interaction");

$adminstmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$adminstmt->execute(array($admin_id , $group_id));
$adminstatus = $adminstmt->fetchAll(PDO::FETCH_ASSOC);
if ($adminstatus[0]['member_is_admin'] == 0) {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
}

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);
if ($userstatus[0]['member_is_admin'] == 1){
    $response = errorState(403, 'forbidden', 'Cannot block a user who is an admin.');
    echo json_encode($response);
    exit();
}

$updatestmt = $con->prepare('UPDATE `group_members` SET `member_can_interaction`= ? WHERE `member_id`= ? AND `group_id`= ?');
$updatestmt->execute(array($can_interaction,$user_id,$group_id));
$count =  $updatestmt->rowCount();
if($count==0){
    $response = errorState(500,'db_error','Error changing the user status. Please try again later.');
    echo json_encode($response);
    exit;
}else{
    $response = successState('response', ['massege' => 'user status was changed']);
    echo json_encode($response);
}