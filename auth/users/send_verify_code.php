<?php

include '../../connect.php';
include("../../core/class/app_user/app_user_model.php");
include("../../core/class/verification/verification_code_model.php");

$email = postRequest('email');
$verificationType = postRequest('verificationType');

if ($verificationType == VerificationType::forgotPassword || $verificationType == VerificationType::createEmail) {

    $stmt = selectFromAppUserByEmail($email, $con);
    $count = $stmt->rowCount();

    if ($count > 0) {
        $array = $stmt->fetch(PDO::FETCH_ASSOC);
        $user =  User::fromArray($array);
        if (($user->status == UserStatus::pending && $user->statusMessage == 'want to verify the account') || $user->status == UserStatus::active) {
            if ($user->provider != UserProvider::emailPassword) {
                $response = errorState(403, 'invalid-code-error', 'User is not email_password to send verification code.');
            } else {
                sendUserVerifyEmail(con: $con, user: $user, verificationType: $verificationType);
                $response = successState('user', $user->toArray());
            }
        } else {
            $response = errorState(401, 'invalid-code-error', 'You can\'t send code while your account is inactive');
        }
    } else {
        $response = errorState(401, 'auth-error', 'The email you entered does not exist');
    }
} else {
    $response = errorState(400, 'invalid-code-error', 'Invalid verification type.');
}
echo json_encode($response);
