<?php
include "../../connect.php";

$group_id = postRequest("group_id");

$groupStmt =  $con->prepare('SELECT * FROM `group_deails` WHERE group_id=?');
$groupStmt->execute(array($group_id));

$find=$groupStmt->rowCount();
if ($find == 0) {
    $errorResponse = errorState(401, 'no_group_found', 'this is group not found.');
    echo json_encode($errorResponse);
    exit;
}

$group = $groupStmt->fetchAll(PDO::FETCH_ASSOC);

$response = successState("group", $group);
echo json_encode($response, JSON_PRETTY_PRINT);
