<?php
include "../../connect.php";

$user_id = postRequest("user_id");

$stmt = $con->prepare("SELECT `group_deails`.*
FROM `group_deails`
INNER JOIN `group_members` ON `group_deails`.`group_id` = `group_members`.`group_id`
WHERE `group_members`.`member_id` = ? AND `group_deails`.`group_owner_id` = ? ");
$stmt->execute(array($user_id, $user_id));
$groupinfo = $stmt->fetchAll(PDO::FETCH_ASSOC);
$response = successState('groups', $groupinfo);
echo json_encode($response, JSON_PRETTY_PRINT);

$action_type = "group_crud";
$action_details = "user is view his groups you own";
action($user_id, $action_type, $action_details, $con);
