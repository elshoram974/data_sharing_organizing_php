<?php
function updateLastLogin(PDO $con, int $userId): string
{
    $loginTime = date('Y-m-d H:i:s');
    $updateStmt = $con->prepare("UPDATE `app_users` SET `user_lastlogin` = ? WHERE `user_id` = ?");
    $updateStmt->execute(array($loginTime, $userId));

    return $loginTime;
}
