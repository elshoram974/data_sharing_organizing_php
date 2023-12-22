<?php
include("connect.php");

$stmt =  $con->prepare("SELECT * FROM `users`");
$stmt->execute();

http_response_code(401); 

print_r($stmt->fetchAll(PDO::FETCH_ASSOC));

echo "done";
