<?php
include("../../connect.php");
include("../../core/class/app_user/app_user_model.php");


$email = postRequest('email');
$password = postRequest('password');

$stmt = selectFromAppUser($email, $con);

$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);

    $user =  User::fromArray($array);

    if ($user->password == 'User created by another provider') {
        $response = errorState(401, 'User created by another provider');
    }
    // Hash the provided password and compare it with the stored hash
    elseif (password_verify($password, $user->password)) {

        if (!$user->isVerified) sendUserVerifyEmail($email);

        $user->lastLogin = new DateTime(updateLastLogin($con, $user->id));
        $response = successState('user', $user->toArray());
    } else {
        $response = errorState(401, 'Error in password');
    }
} else {
    $response = errorState(401, 'The email you entered does not exist');
}

echo json_encode($response);
