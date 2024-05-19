<?php
include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest('group_id');
$member_id = postRequest('member_id');

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);
if ($userstatus[0]['member_is_admin'] == 0) {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
}

$state2Stmt = $con->prepare("SELECT `group_owner_id` FROM `group_deails` WHERE `group_id` = ?");
$state2Stmt->execute(array($group_id));
$userstatus = $state2Stmt->fetch(PDO::FETCH_ASSOC);
if($userstatus['group_owner_id'] == $member_id){
    $response = errorState(403, 'access_denied', 'you can not remove the owner of group.');
    echo json_encode($response);
    exit;
}else{
    $deletestmt = $con->prepare('DELETE FROM `group_members` WHERE `member_id`= ? AND  `group_id` =?');
    $deletestmt->execute(array($member_id,$group_id));
    $response = successState('response', ['massege' => 'this user has been deleted successfully']);
    echo json_encode($response);
}
