<?php
include "../../../connect.php";
$group_id = postRequest('group_id');

$stmt = $con->prepare("SELECT `group_members`.*,
`app_users`.user_email,user_first_name,user_last_name,user_lastlogin,user_image FROM
`group_members`,`app_users` WHERE
`app_users`.`user_id`=`group_members`.`member_id` AND `group_members`.`group_id` = ?
ORDER BY CONCAT(`user_first_name`, ' ', `user_last_name`) ASC");
$stmt->execute(array($group_id));
$count = $stmt->rowCount();
if ($count > 0) {
    $users = $stmt->fetchall(PDO::FETCH_ASSOC);
    $response = successState('users',$users);
}else{
    $response = errorState(404, 'no_users_found', 'No users found.');
}
echo json_encode($response,JSON_PRETTY_PRINT);