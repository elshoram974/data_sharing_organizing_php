<?php

include "../../connect.php";

$admin_id = postRequest("a_id");
$admin_new_first_name = postRequest("new_first_name");
$admin_new_last_name = postRequest("new_last_name");


$updateStmt = $con->prepare("UPDATE admins SET a_first_name = ? , a_last_name = ? WHERE a_id = ?");
$updateStmt->execute(array($admin_new_first_name, $admin_new_last_name, $admin_id));

$Stmt = $con->prepare("SELECT `admins`.* FROM admins WHERE a_id = ?");
$Stmt->execute(array($admin_id));
$data = $Stmt->fetch(PDO::FETCH_ASSOC);
$response = successState("admin", $data);
echo json_encode($response,JSON_PRETTY_PRINT);