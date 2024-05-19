<?php
include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest('group_id');
$member_id = postRequest('member_id');
$is_admin = postRequest('is_admin');

if($is_admin=='true'){
    $is_admin=1;
}else{
    $is_admin=0;
}

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
    $response = errorState(403, 'access_denied', 'you can not change the permissions of owner of group.');
    echo json_encode($response);
    exit;
}else{
    $stmt = $con->prepare("UPDATE `group_members` SET `member_is_admin`= ? WHERE `group_id` =? AND `member_id` =?");
    $stmt->execute(array($is_admin,$group_id,$member_id));
    if($is_admin==1){
        $response = successState('response', ['massege' => 'this user has become admin']);
        echo json_encode($response);
    }else{
    $response = successState('response', ['massege' => 'this user has not become admin']);
    echo json_encode($response);
    }
}