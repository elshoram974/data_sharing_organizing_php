<?php

include '../../connect.php';
include("../../core/class/admin_model.php");

$adminId = postRequest('adminId');
$code = postRequest('code');

$stmt = selectFromAdminsById($adminId, $con);

$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    $admin =  Admin::fromArray($array);

    if ($admin->verificationCode == $code) {

        $admin->verificationCode = null;
        $admin->lastLogin = new DateTime();

        $stmt = $con->prepare("UPDATE `admins` SET `a_verified_code`=?, `a_last_login` = ? WHERE `a_id`= ?");
        $stmt->execute([null, $admin->lastLogin->format('Y-m-d H:i:s'), $admin->id]);


        $response = successState('admin', $admin->toArray());
    } else {
        $response = errorState(400, 'invalid-code-error', 'Invalid verification code');
    }
} else {
    $response = errorState(401, 'auth-error', 'The adminId you entered does not exist');
}

echo json_encode($response);
