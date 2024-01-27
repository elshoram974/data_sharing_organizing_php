<?php

include("send_mail.php");

function sendUserVerifyEmail(PDO $con, User $user, string $verificationType): void
{

    if ($verificationType == VerificationType::createEmail) $subject = 'Activate Your New Account';
    else $subject = 'Password Reset';


    deleteUserVerifyCode(userId: $user->id, con: $con);
    $rand = rand(100000, 999999);

    $stmt = $con->prepare("INSERT INTO `verification_codes`(`verification_user`, `verification_code`, `verification_type`,`verification_created_at`) VALUES (?,?,?,?)");
    $stmt->execute([$user->id, "$rand", $verificationType, date('Y-m-d H:i:s')]);

    sendMail($user->email,  $user->firstName, $subject, htmlTemplate($rand, $user->firstName, $subject));
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

    sendMail($admin->email,  $admin->firstName, 'Forget password', htmlTemplate($rand, $admin->firstName, 'Forget password'));
}

function htmlTemplate(int $verificationCode, string $userName = 'User', string $subject): string
{
    // Load the HTML template
    $htmlTemplate = file_get_contents('https://thiet.mrecode.com/api/core/assets/mail_body.html');

    // Replace placeholders with actual values
    $htmlTemplate = str_replace('{{USER_NAME}}', $userName, $htmlTemplate);
    $htmlTemplate = str_replace('{{VERIFICATION_CODE}}', $verificationCode, $htmlTemplate);
    $htmlTemplate = str_replace('{{EMAIL_SUBJECT}}', $subject, $htmlTemplate);
    $htmlTemplate = str_replace('{{CURRENT_YEAR}}', date('Y'), $htmlTemplate);

    return $htmlTemplate;
}
