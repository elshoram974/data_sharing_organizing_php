<?php

include "../../connect.php";

$admin_id = postRequest("a_id");
$admin_current_password = postRequest("current_password");
$admin_new_password = postRequest("new_password");

$checkStmt = $con->prepare("SELECT a_password FROM admins WHERE a_id = ?");
$checkStmt->execute(array($admin_id));
$adminpass = $checkStmt->fetchAll(PDO::FETCH_ASSOC);
if ($admin_current_password != $adminpass[0]['a_password']) {
    $response = errorState(401, 'authentication_error', 'password is wrong');
    echo json_encode($response);
    exit;
}

if (strlen($admin_new_password) < 8) {
    $response = errorState(401, 'authentication_error', 'Password must be at least 8 characters long');
    echo json_encode($response);
    exit;
}

$updateStmt = $con->prepare("UPDATE admins SET a_password = ? WHERE a_id=?");
$updateStmt->execute(array($admin_new_password, $admin_id));

$Stmt = $con->prepare("SELECT `admins`.* FROM admins WHERE a_id = ?");
$Stmt->execute(array($admin_id));
$data = $Stmt->fetch(PDO::FETCH_ASSOC);
$response = successState("admin", $data);
echo json_encode($response,JSON_PRETTY_PRINT);