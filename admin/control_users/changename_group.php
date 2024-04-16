<?php

include "../../connect.php";

$group_id = postRequest("g_id");
$new_g_name = postRequest("new_name");


$updateStmt = $con->prepare("UPDATE group_deails SET group_name = ? WHERE group_id = ?");
$updateStmt->execute(array($new_g_name, $group_id));

$Stmt = $con->prepare("SELECT `group_deails`.* FROM group_deails WHERE group_id = ?");
$Stmt->execute(array($group_id));
$data = $Stmt->fetch(PDO::FETCH_ASSOC);
$response = successState("group", $data);
echo json_encode($response,JSON_PRETTY_PRINT);