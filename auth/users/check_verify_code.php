<?php

include '../../connect.php';
include("../../core/class/app_user/app_user_model.php");
include("../../core/class/verification/verification_code_model.php");

$email = postRequest('email');
$code = postRequest('code');

$stmt = selectFromAppUser($email, $con);

$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    $user =  User::fromArray($array);

    $stmt = $con->prepare("SELECT * FROM `verification_codes` WHERE `verification_user` = ?");
    $stmt->execute([$user->id]);
    if ($stmt->rowCount() > 0) {
        $array = $stmt->fetch(PDO::FETCH_ASSOC);
        $verificationCode =  VerificationCode::fromArray($array);


        $timeDifference = getDifferenceTimeFromNow($verificationCode->createDate);
        if ($timeDifference <= 3600) {

            if ($verificationCode->code == $code) {

                deleteUserVerifyCode($verificationCode->id, $con);

                $stmt = $con->prepare("UPDATE `app_users` SET `user_is_verified`= ? WHERE `user_id` = ?");
                $stmt->execute([true, $user->id]);

                $stmt = selectFromAppUser($user->email, $con);
                $array = $stmt->fetch(PDO::FETCH_ASSOC);
                $user =  User::fromArray($array);

                $response = successState('user', $user->toArray());
            } else {
                $response = errorState(400, 'Invalid verification code');
            }
        } else {
            sendUserVerifyEmail($email);
            $response = errorState(400, 'The verification code has expired. we sent another code');
        }
    } else {
        sendUserVerifyEmail($email);
        $response = errorState(400, 'The verification code has expired. we sent another code');
    }
} else {
    $response = errorState(401, 'The email you entered does not exist');
}

echo json_encode($response);
