<?php
function sendUserVerifyEmail(string $email, string $verificationType)
{
}

function deleteUserVerifyCode(int $verificationCodeId, PDO $con): void
{
    $stmt = $con->prepare("DELETE FROM `verification_codes` WHERE `verification_id` = ?");
    $stmt->execute([$verificationCodeId]);
}

function sendAdminVerifyEmail(string $email)
{
}
