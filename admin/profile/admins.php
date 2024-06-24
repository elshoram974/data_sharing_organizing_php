<?php
include "../../connect.php";

$adminsStmt =  $con->prepare('SELECT * FROM admins');
$adminsStmt->execute();
$admins = $adminsStmt->fetchAll(PDO::FETCH_ASSOC);

$response = successState("admins", $admins);
echo json_encode($response, JSON_PRETTY_PRINT);