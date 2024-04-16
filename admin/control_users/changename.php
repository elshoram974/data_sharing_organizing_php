<?php
include "../../connect.php";

$user_id = postRequest("user_id");
$user_new_first_name = postRequest("new_first_name");
$user_new_last_name = postRequest("new_last_name");

if (empty($user_new_first_name) || empty($user_new_last_name)) {

    $response = errorState(400, 'Bad Request', 'Missing required parameters');
    echo json_encode($response);
    exit;
}

$updateStmt = $con->prepare("UPDATE app_users SET user_first_name = ? , user_last_name = ? WHERE user_id = ?");
$updateStmt->execute(array($user_new_first_name, $user_new_last_name, $user_id));

$Stmt = $con->prepare("SELECT `app_users`.* FROM app_users WHERE user_id = ?");
$Stmt->execute(array($user_id));
$data = $Stmt->fetchAll(PDO::FETCH_ASSOC);
$response = successState("user", $data);
echo json_encode($response);
