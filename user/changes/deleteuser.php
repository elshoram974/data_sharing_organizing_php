<?php

include "../../connect.php";

$user_id = postRequest("user_id");

$selectgroupsStmt = $con->prepare('SELECT group_id FROM group_members WHERE member_id = ? AND member_is_admin = ?');
$selectgroupsStmt->execute(array($user_id,"1"));
$groups = $selectgroupsStmt->fetchAll(PDO::FETCH_COLUMN);
$selectgroupsStmt->closeCursor();


foreach ($groups as $group_id) {
    $dminStmt = $con->prepare('SELECT group_members.member_id 
    FROM group_members 
    WHERE group_id = ? AND member_id != ? 
    ORDER BY RAND() LIMIT 1');
    $dminStmt->execute(array($group_id, $user_id));
    $admin =  $dminStmt->fetchColumn();

    $changeadminStmt = $con->prepare('UPDATE group_members
    SET member_is_admin = ?
    WHERE group_id = ? AND member_id = ? ;');
    $changeadminStmt->execute(["1",$group_id, $admin]);
    $changeadminStmt->closeCursor();
}

$deleteStmt = $con->prepare('DELETE FROM group_members WHERE member_id  = ?;
                             DELETE FROM help_and_support WHERE user_id = ?;
                             DELETE FROM payment_user_plan WHERE user_id = ?;
                             DELETE FROM user_action_history WHERE user_id = ?;
                             DELETE FROM user_devices WHERE user_id = ?;
                             DELETE FROM verification_codes WHERE verification_user = ?;');
$deleteStmt->execute(array($user_id, $user_id, $user_id, $user_id, $user_id, $user_id));
$deleteStmt->closeCursor();

$changestateStmt = $con->prepare('UPDATE app_users SET user_status = ? WHERE user_id = ?');
$changestateStmt->execute(array('deleted', $user_id));


$response = successState('response', ['massege' => 'User has been deleted successfully']);

echo json_encode($response);

$action_type = "account_crud";
$action_details = "user is deleted";
action($user_id, $action_type, $action_details, $con);
