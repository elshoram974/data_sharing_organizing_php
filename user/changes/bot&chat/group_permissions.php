<?php
include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest('group_id');
$discussion_type = postRequest('discussion_type',true);
$access_type = postRequest('access_type',true);

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);

if ($userstatus[0]['member_is_admin'] == 0) {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
}

if(empty($discussion_type)){
    $stmt = $con->prepare("UPDATE `group_deails` SET `group_access_type`= ? WHERE `group_id` =?");
    $stmt->execute(array($access_type,$group_id));
    $response = successState('response', ['massege' => 'the group_access_type is changed.']);
}elseif(empty($access_type)){
    $stmt = $con->prepare("UPDATE `group_deails` SET `group_discussion_type`= ? WHERE `group_id` =?");
    $stmt->execute(array($discussion_type,$group_id));
    $response = successState('response', ['massege' => 'the group_discussion_type is changed.']);
}

echo json_encode($response,JSON_PRETTY_PRINT);