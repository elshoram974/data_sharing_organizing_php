<?php

function action(int $user_id , string $action_type , string $action_details , PDO $con): PDOStatement
{
    $insertStmt = $con->prepare("INSERT INTO `user_action_history`( `user_id`, `action_type`, `action_details`) VALUES (?,?,?)") ;
    $insertStmt->execute(array($user_id,$action_type,$action_details));
    return $insertStmt;
}