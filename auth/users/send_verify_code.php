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

        sendUserVerifyEmail($user->email, $verificationType);
        $response = successState('user', $user->toArray());
    } else {
        $response = errorState(401, 'The email you entered does not exist');
    }
} else {
    $response = errorState(400, 'Invalid verification type.');
}
echo json_encode($response);
