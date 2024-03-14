<?php
include "../../connect.php";
$user_id = postRequest("user_id");
$user_password = postRequest("user_password");

$action_type = "page_view";
$action_details = "user is view home page";
action($user_id, $action_type, $action_details, $con);

$checkStmt = $con->prepare("SELECT user_password FROM app_users WHERE user_id = ?");
$checkStmt->execute(array($user_id));
$userpassword = $checkStmt->fetchAll(PDO::FETCH_ASSOC);
if (!password_verify($user_password, $userpassword[0]['user_password'])) {
    $response = errorState(401, 'authentication_error', 'password is changed');
    echo json_encode($response);
    exit;
}

$stateStmt = $con->prepare("SELECT user_status FROM app_users WHERE user_id = ?");
$stateStmt->execute(array($user_id));
$userstatus = $stateStmt->fetchAll(PDO::FETCH_ASSOC);
if ($userstatus[0]['user_status'] != "active") {
    $response = errorState(400, 'user_inactive', 'User is not active!');
    echo json_encode($response);
    exit;
}



$stmt = $con->prepare("SELECT `group_deails`.*
FROM `group_deails`
INNER JOIN `group_members` ON `group_deails`.`group_id` = `group_members`.`group_id`
WHERE `group_members`.`member_id` = ?");
$stmt->execute(array($user_id));
$groupinfo = $stmt->fetchAll(PDO::FETCH_ASSOC);
$response = successState('groups', $groupinfo);
echo json_encode($response, JSON_PRETTY_PRINT);

$groupsStmt = $con->prepare("SELECT group_id FROM group_members WHERE member_id = ?");
$groupsStmt->execute(array($user_id));
$usersgroup = $groupsStmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($usersgroup as $value) {

    $group_id = $value['group_id'];
    $activityStmt = $con->prepare("SELECT * FROM group_activity WHERE activity_group_id = ? ORDER BY activity_id DESC LIMIT 1");
    $activityStmt->execute(array($group_id));
    $activities = $activityStmt->fetchAll(PDO::FETCH_ASSOC);

    $userStmt =  $con->prepare("SELECT * FROM `app_users` WHERE `user_id`= ? ");
    $userStmt->execute(array($activities[0]["activity_owner_id"]));
    $owner = $userStmt->fetchAll(PDO::FETCH_ASSOC);

    $responseact = successState('activity', $activities);
    $responseact['other_user'] = $owner;

    echo json_encode($responseact, JSON_PRETTY_PRINT);
}
