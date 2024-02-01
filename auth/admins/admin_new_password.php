<?php
include("../../connect.php");
include("../../core/class/admin_model.php");


$adminId = postRequest('adminId');
$newPassword = postRequest('newPassword');

$stmt = selectFromAdminsById($adminId, $con);
$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    $admin =  Admin::fromArray($array);

    if ($newPassword != $admin->password) {

        if (strlen($newPassword) >= 8) {

            $stmt = $con->prepare("UPDATE `admins` SET `a_password`=? WHERE `a_id`=?");
            $stmt->execute([$newPassword, $adminId]);

            $admin->password = $newPassword;

            $response = successState('admin', $admin->toArray());
        } else {
            $response = errorState(400, 'edit-error', 'The password is very weak');
        }
    } else {
        $response = errorState(400, 'edit-error', 'You can\'t use the same previous password');
    }
} else {
    $response = errorState(409, 'auth-error', 'The adminId you entered does not exist');
}

echo json_encode($response);
