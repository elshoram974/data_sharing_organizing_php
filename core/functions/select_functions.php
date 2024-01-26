<?php
function selectFromAppUserByEmail(string $email, PDO $con): PDOStatement
{
    $stmt = $con->prepare("SELECT * FROM `app_users` WHERE `user_email` = ?");
    $stmt->execute(array($email));
    return $stmt;
}
function selectFromAppUserById(int $userId, PDO $con): PDOStatement
{
    $stmt = $con->prepare("SELECT * FROM `app_users` WHERE `user_id` = ?");
    $stmt->execute(array($userId));
    return $stmt;
}
