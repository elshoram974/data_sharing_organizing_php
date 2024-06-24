<?php
include "../../connect.php";

$user_id = postRequest("user_id");

$userStmt =  $con->prepare('SELECT * FROM app_users WHERE user_id=?');
$userStmt->execute(array($user_id));
$user = $userStmt->fetchAll(PDO::FETCH_ASSOC);

$groupsStmt =  $con->prepare('SELECT `group_members`.`group_id`,`group_deails`.`group_name` FROM
`group_members`,`group_deails` WHERE
`group_members`.`group_id` = `group_deails`.`group_id` AND
`group_members`.`member_id`=?');
$groupsStmt->execute(array($user_id));
$groups = $groupsStmt->fetchAll(PDO::FETCH_ASSOC);

$response = successState("user", $user);
$response["groups"] = $groups;
echo json_encode($response, JSON_PRETTY_PRINT);