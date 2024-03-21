<?php
include "../../connect.php";

$user_id = postRequest("user_id");
$user_current_password = postRequest("current_password");
$user_new_password = postRequest("new_password");

$providerStmt = $con->prepare("SELECT user_provider FROM app_users WHERE user_id = ?");
$providerStmt->execute(array($user_id));
$provider = $providerStmt->fetchAll(PDO::FETCH_ASSOC);
if ($provider[0]['user_provider'] != 'email_password') {
    $response = errorState(403, "Forbidden", "This action is not allowed for you becouse  you are signup  with social account.");
    echo json_encode($response);
    exit();
}

$checkStmt = $con->prepare("SELECT user_password FROM app_users WHERE user_id = ?");
$checkStmt->execute(array($user_id));
$userpassword = $checkStmt->fetchAll(PDO::FETCH_ASSOC);
if (!password_verify($user_current_password, $userpassword[0]['user_password'])) {
    $response = errorState(401, 'authentication_error', 'password is wrong');
    echo json_encode($response);
    exit;
}

if (strlen($user_new_password) < 8) {
    $response = errorState(401, 'authentication_error', 'Password must be at least 8 characters long');
    echo json_encode($response);
    exit;
}

$hashedPass = password_hash($user_new_password, PASSWORD_DEFAULT);
$updateStmt = $con->prepare("UPDATE app_users SET user_password = ? WHERE user_id=?");
$updateStmt->execute(array($hashedPass, $user_id));

$Stmt = $con->prepare("SELECT `app_users`.* FROM app_users WHERE user_id = ?");
$Stmt->execute(array($user_id));
$data = $Stmt->fetch(PDO::FETCH_ASSOC);
$response = successState("user", $data);
echo json_encode($response);

$action_type = "account_crud";
$action_details = "user is changed password";
action($user_id, $action_type, $action_details, $con);
