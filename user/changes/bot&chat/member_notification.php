<?php
include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest('group_id');
$member_notification = postRequest('notification');

$stmt = $con->prepare("UPDATE `group_members` SET `member_notification`= ? WHERE `group_id` =? AND `member_id` =?");
$stmt->execute(array($member_notification,$group_id,$user_id));
$response = successState('response', ['massege' => 'the member_notification is changed.']);
echo json_encode($response,JSON_PRETTY_PRINT);