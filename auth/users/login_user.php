<?php
include("../../connect.php");
include("../../core/class/app_user/app_user_model.php");


$email = postRequest('email');
$password = postRequest('password');

$stmt = $con->prepare("SELECT * FROM `app_users` WHERE `user_email` = ?");
$stmt->execute(array($email));

$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);

    $user =  User::fromArray($array);

    // Hash the provided password and compare it with the stored hash
    if (password_verify($password, $user->password)) {

        $user->lastLogin = new DateTime(updateLastLogin($con, $user->id));
        $response = successState('user', $user->toArray());
    } else {
        $response = errorState(401, 'Error in password');
    }
} else {
    $response = errorState(401, 'The email you entered does not exist');
}

echo json_encode($response);
