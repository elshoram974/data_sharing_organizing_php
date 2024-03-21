<?php

include "../../connect.php";

$groupsStmt = $con->prepare('SELECT * FROM `group_deails`');
$groupsStmt->execute();
$groups = $groupsStmt->fetchAll(PDO::FETCH_ASSOC);

$numgroups = $groupsStmt->rowCount();

if ($numgroups == 0) {
    $errorResponse = errorState(404, 'no_groups_found', 'No groups found.');
    echo json_encode($errorResponse);
    exit;
}

$response = successState("groups", $groups);
$response["total"] = $numgroups;
echo json_encode($response, JSON_PRETTY_PRINT);