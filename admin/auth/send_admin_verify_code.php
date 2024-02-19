<?php

include '../../connect.php';
include("../../core/class/admin_model.php");

$email = postRequest('email');

$stmt = selectFromAdminsByEmail($email, $con);
$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    $admin =  Admin::fromArray($array);

    sendAdminVerifyEmail($con, $admin);
    $response = successState('admin', $admin->toArray());
} else {
    $response = errorState(401, 'auth-error', 'The email you entered does not exist');
}

echo json_encode($response);
