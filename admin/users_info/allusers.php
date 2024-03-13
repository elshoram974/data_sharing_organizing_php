<?php

include "../../connect.php";

$usersStmt = $con->prepare('SELECT * FROM app_users');
$usersStmt->execute();
$users = $usersStmt->fetchAll(PDO::FETCH_ASSOC);

$numUsers = count($users);

if ($numUsers == 0) {
    $errorResponse = errorState(404, 'no_users_found', 'No users found.');
    echo json_encode($errorResponse);
    exit;
}

$response = successState("users", $users);
$response["total"] = $numUsers;
echo json_encode($response, JSON_PRETTY_PRINT);
