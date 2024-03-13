<?php

include "../../connect.php";

$user_id = postRequest("user_id");

$deleteStmt = $con->prepare('DELETE FROM group_members WHERE member_id  = ?;
                             DELETE FROM help_and_support WHERE user_id = ?;
                             DELETE FROM payment_user_plan WHERE user_id = ?;
                             DELETE FROM user_action_history WHERE user_id = ?;
                             DELETE FROM user_devices WHERE user_id = ?;
                             DELETE FROM verification_codes WHERE verification_user = ?;');
$deleteStmt->execute(array($user_id, $user_id, $user_id, $user_id, $user_id, $user_id));
$deleteStmt->closeCursor();


$selectgroupsStmt = $con->prepare('SELECT group_id FROM group_deails WHERE group_owner_id = ?');
$selectgroupsStmt->execute(array($user_id));
$groups = $selectgroupsStmt->fetchAll(PDO::FETCH_COLUMN);
$selectgroupsStmt->closeCursor();


foreach ($groups as $group_id) {
    $changeadminStmt = $con->prepare('UPDATE group_deails
    SET group_owner_id = (
        SELECT member_id
        FROM group_members
        WHERE group_id = ?
        ORDER BY member_join_date ASC
        LIMIT 1
    )
    WHERE group_id = ?;');
    $changeadminStmt->execute([$group_id, $group_id]);
    $changeadminStmt->closeCursor();
}

$changestateStmt = $con->prepare('UPDATE app_users SET user_status = ? WHERE user_id = ?');
$changestateStmt->execute(array('deleted', $user_id));


$response = successState('response', ['massege' => 'User has been deleted successfully']);

echo json_encode($response);
