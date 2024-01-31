<?php
include("../../connect.php");
include("../../core/class/app_user/app_user_model.php");


$userId = postRequest('userId');
$newPassword = postRequest('newPassword');

$stmt = selectFromAppUserById($userId, $con);
$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    $user =  User::fromArray($array);

    $storedHash = $user->password;

    if ($user->provider != UserProvider::emailPassword) {
        $response = errorState(403, 'auth-error', 'User is not email_password to make new pass');
    } elseif (!password_verify($newPassword, $storedHash)) {

        if (strlen($newPassword) >= 8) {

            $newHashPassword = makeHashPassword($newPassword);

            $stmt = $con->prepare("UPDATE `app_users` SET `user_password`=? WHERE `user_id`=?");
            $stmt->execute([$newHashPassword, $userId]);

            $user->password = $newHashPassword;

            $response = successState('user', $user->toArray());
        } else {
            $response = errorState(400, 'edit-error', 'The password is very weak');
        }
    } else {
        $response = errorState(400, 'edit-error', 'You can\'t use the same previous password');
    }
} else {
    $response = errorState(409, 'auth-error', 'The userId you entered does not exist');
}

echo json_encode($response);
