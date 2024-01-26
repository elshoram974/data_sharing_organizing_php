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

    $storedHash = $admin->password;

    if (!password_verify($newPassword, $storedHash)) {

        if (strlen($newPassword) >= 8) {

            $newHashPassword = makeHashPassword($newPassword);

            $stmt = $con->prepare("UPDATE `admins` SET `a_password`=? WHERE `a_id`=?");
            $stmt->execute([$newHashPassword, $adminId]);

            $admin->password = $newHashPassword;

            $response = successState('admin', $admin->toArray());
        } else {
            $response = errorState(400, 'The password is very weak');
        }
    } else {
        $response = errorState(400, 'You can\'t use the the same previous password');
    }
} else {
    $response = errorState(409, 'The adminId you entered does not exist');
}

echo json_encode($response);
