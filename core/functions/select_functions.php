<?php
function selectFromAppUser($email, $con): PDOStatement
{
    $stmt = $con->prepare("SELECT * FROM `app_users` WHERE `user_email` = ?");
    $stmt->execute(array($email));
    return $stmt;
}
