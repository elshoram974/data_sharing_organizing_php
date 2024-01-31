<?php

include("../../connect.php");
include("../../core/class/admin_model.php");


$email = postRequest('email');
$password = postRequest('password');

$stmt = selectFromAdminsByEmail($email, $con);

$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);

    $admin =  Admin::fromArray($array);

    // Hash the provided password and compare it with the stored hash
    if ($password == $admin->password) {

        $admin->lastLogin = new DateTime(updateAdminLastLogin($con, $admin->id));
        $response = successState('admin', $admin->toArray());
    } else {
        $response = errorState(401, 'auth-error', 'Error in password');
    }
} else {
    $response = errorState(401, 'auth-error', 'The email you entered does not exist');
}

echo json_encode($response);
