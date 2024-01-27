<?php

include("send_mail.php");

function sendUserVerifyEmail(PDO $con, User $user, string $verificationType): void
{


    deleteUserVerifyCode(userId: $user->id, con: $con);
    $rand = rand(100000, 999999);

    $stmt = $con->prepare("INSERT INTO `verification_codes`(`verification_user`, `verification_code`, `verification_type`,`verification_created_at`) VALUES (?,?,?,?)");
    $stmt->execute([$user->id, "$rand", $verificationType, date('Y-m-d H:i:s')]);

    sendMail($user->email,  $user->firstName, $verificationType, "string $rand");
}

function deleteUserVerifyCode(int $userId, PDO $con): int
{
    $stmt = $con->prepare("DELETE FROM `verification_codes` WHERE `verification_user` = ?");
    $stmt->execute([$userId]);
    return $stmt->rowCount();
}

function sendAdminVerifyEmail(PDO $con, Admin $admin)
{


    $rand = rand(100000, 999999);

    $stmt = $con->prepare("UPDATE `admins` SET `a_verified_code`=? WHERE `a_id`= ?");
    $stmt->execute([$rand, $admin->id]);

    sendMail($admin->email,  $admin->firstName, 'Forget password', "string $rand");
}
