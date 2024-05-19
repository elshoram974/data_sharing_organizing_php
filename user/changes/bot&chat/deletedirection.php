<?php

include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest("group_id");
$direction_id = postRequest("direction_id");

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id, $group_id));

$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);

$state2Stmt = $con->prepare("SELECT direction_owner_id FROM group_activity_direction WHERE direction_id = ? AND  group_id = ?");

$state2Stmt->execute(array($direction_id, $group_id));

$owner = $state2Stmt->fetchAll(PDO::FETCH_ASSOC);

if ($userstatus[0]['member_is_admin'] == 0 and $owner[0]['direction_owner_id'] != "$user_id") {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
}

$deletestmt = $con->prepare('DELETE FROM `group_activity_direction` WHERE `direction_id`= ?');
$deletestmt->execute(array($direction_id));


$count =  $deletestmt->rowCount();

if ($count > 0) {
    $response = successState('response', ['massege' => 'direction has been deleted successfully']);
} else {
    $response = errorState(500, 'db_error', 'Error deleting direction from database. Please try again later.');
}

echo json_encode($response);
