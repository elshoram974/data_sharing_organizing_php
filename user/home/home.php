<?php
include "../../connect.php";
$user_id = postRequest("user_id");
$user_password = postRequest("user_password");

$action_type = "page_view";
$action_details = "user is view home page";
action($user_id, $action_type, $action_details, $con);

$dateTimeCairo = new DateTime("now", new DateTimeZone("Africa/Cairo"));
$currentDateTimeCairo = $dateTimeCairo->format('Y-m-d H:i:s');
$timeupdate = $con->prepare("UPDATE `app_users` SET `user_lastlogin`= ? WHERE `user_id`= ?");
$timeupdate->execute(array($currentDateTimeCairo, $user_id));

$check1Stmt = $con->prepare("SELECT user_provider FROM app_users WHERE user_id = ?");
$check1Stmt->execute(array($user_id));
$userprov = $check1Stmt->fetchAll(PDO::FETCH_ASSOC);
if ($userprov == 'email_password') {
    $check2Stmt = $con->prepare("SELECT user_password FROM app_users WHERE user_id = ?");
    $check2Stmt->execute(array($user_id));
    $userpassword = $check2Stmt->fetchAll(PDO::FETCH_ASSOC);
    if (!password_verify($user_password, $userpassword[0]['user_password'])) {
        $response = errorState(401, 'authentication_error', 'password is changed');
        echo json_encode($response);
        exit;
    }
}



$stateStmt = $con->prepare("SELECT user_status FROM app_users WHERE user_id = ?");
$stateStmt->execute(array($user_id));
$userstatus = $stateStmt->fetchAll(PDO::FETCH_ASSOC);
if ($userstatus[0]['user_status'] != "active") {
    $response = errorState(400, 'user_inactive', 'User is not active!');
    echo json_encode($response);
    exit;
}



$stmt = $con->prepare("SELECT `group_deails`.* , `group_members`.*
FROM `group_deails`
INNER JOIN `group_members` ON `group_deails`.`group_id` = `group_members`.`group_id`
WHERE `group_members`.`member_id` = ?");
$stmt->execute(array($user_id));
$groupinfo = $stmt->fetchAll(PDO::FETCH_ASSOC);
$response = successState('groups', $groupinfo);


$selectStmt = $con->prepare("SELECT app_users.* FROM app_users WHERE user_id = ?");
$selectStmt->execute(array($user_id));
$data = $selectStmt->fetch(PDO::FETCH_ASSOC);
$response['user'] = $data;

echo json_encode($response, JSON_PRETTY_PRINT);
