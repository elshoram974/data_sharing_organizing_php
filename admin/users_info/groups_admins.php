<?php
include "../../connect.php";

$adminsgroupsStmt =  $con->prepare('SELECT `group_members`.group_id,member_id,
`group_deails`.`group_name`,
`app_users`.user_first_name,user_last_name FROM
`group_members`,`group_deails`,`app_users` WHERE
`group_members`.`group_id` = `group_deails`.`group_id` AND
`group_members`.`member_id` = `app_users`.`user_id` AND
`group_members`.`member_is_admin`=?');
$adminsgroupsStmt->execute(array(1));
$adminsgroups = $adminsgroupsStmt->fetchAll(PDO::FETCH_ASSOC);

$response = successState("admins", $adminsgroups);
echo json_encode($response, JSON_PRETTY_PRINT);
