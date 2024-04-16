<?php

include "../../connect.php";

$user_id = postRequest("user_id");
$user_new_password = postRequest("new_password");

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
$data = $Stmt->fetchAll(PDO::FETCH_ASSOC);
$response = successState("password", [$user_new_password]);
$response["user"] = $data;
echo json_encode($response);
