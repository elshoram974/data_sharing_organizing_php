<?php
include "../../connect.php";

$user_id = postRequest("user_id");

$userStmt =  $con->prepare('SELECT * FROM app_users WHERE user_id=?');
$userStmt->execute(array($user_id));
$user = $userStmt->fetchAll(PDO::FETCH_ASSOC);

$response = successState("user", $user);
echo json_encode($response, JSON_PRETTY_PRINT);
