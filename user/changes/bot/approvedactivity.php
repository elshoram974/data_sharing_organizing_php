<?php

include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest("group_id");
$activity_id = postRequest("activity_id");
$approved = postRequest("approved");

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);

if ($userstatus[0]['member_is_admin'] == 0) {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
}

$updatestmt = $con->prepare('UPDATE `group_activity` SET `activity_is_approved`= ? WHERE `activity_id`= ? AND `activity_group_id`= ?');
$updatestmt->execute(array($approved,$activity_id,$group_id));

$count =  $updatestmt->rowCount();

if($count>0){
    $response = successState('response', ['massege' => 'activity approved has been updated successfully']);
}else{
	$response = errorState(500,'db_error','Error updating activity approved from database. Please try again later.');
}

echo json_encode($response);
