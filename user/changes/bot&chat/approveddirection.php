<?php

include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest("group_id");
$direction_id = postRequest("direction_id");
$approved = postRequest("approved");

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);

if ($userstatus[0]['member_is_admin'] == 0) {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
}

$updatestmt = $con->prepare('UPDATE `group_activity_direction` SET `direction_is_approved`= ? WHERE `direction_id`= ? AND `group_id`= ?');
$updatestmt->execute(array($approved,$direction_id,$group_id));

$count =  $updatestmt->rowCount();

if($count>0){
    $response = successState('response', ['massege' => 'direction approved has been updated successfully']);
}else{
	$response = errorState(500,'db_error','Error updating direction approved from database. Please try again later.');
}

echo json_encode($response);
