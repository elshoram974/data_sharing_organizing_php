<?php

include '../../connect.php';
include("../../core/class/app_user/app_user_model.php");
include("../../core/class/verification/verification_code_model.php");

$userId = postRequest('userId');
$code = postRequest('code');

$stmt = selectFromAppUserById($userId, $con);

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

                $stmt = selectFromAppUserById($user->id, $con);
                $array = $stmt->fetch(PDO::FETCH_ASSOC);
                $user =  User::fromArray($array);

                $response = successState('user', $user->toArray());
            } else {
                $response = errorState(400, 'Invalid verification code');
            }
        } else {
            sendUserVerifyEmail($user->email);
            $response = errorState(400, 'The verification code has expired. we sent another code');
        }
    } else {
        sendUserVerifyEmail($user->email);
        $response = errorState(400, 'The verification code has expired. we sent another code');
    }
} else {
    $response = errorState(401, 'The userId you entered does not exist');
}

echo json_encode($response);
