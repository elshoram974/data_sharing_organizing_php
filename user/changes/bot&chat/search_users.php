<?php
include "../../../connect.php";
$quere = postRequest('quere');
$page = postRequest('page', true);
$limit = postRequest('limit', true); 

$page = !empty($page) ? (int)$page : 1;
$limit = !empty($limit) ? (int)$limit : 10;

$offset = ($page - 1) * $limit;

$stmt = $con->prepare("SELECT 
 `user_id`,
 `user_first_name`, 
 `user_last_name`, 
 `user_lastlogin`, 
 `user_image` FROM 
 `app_users` WHERE
 `user_email` = ? OR CONCAT(`user_first_name`, ' ', `user_last_name`) LIKE ?
 ORDER BY CONCAT(`user_first_name`, ' ', `user_last_name`) ASC
 LIMIT ? OFFSET ?");

$stmt->bindValue(1, $quere);
$stmt->bindValue(2, "%$quere%");
$stmt->bindValue(3, (int)$limit, PDO::PARAM_INT);
$stmt->bindValue(4, (int)$offset, PDO::PARAM_INT);

$stmt->execute();
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();

if ($count > 0) {
    $response = successState('users', $users);
} else {
    $response = successState('response', ['message' => 'No users found.']);
}

echo json_encode($response, JSON_PRETTY_PRINT);
