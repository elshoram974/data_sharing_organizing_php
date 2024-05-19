<?php
include "../../../connect.php";
$quere = postRequest('quere');

$stmt = $con->prepare("SELECT 
 `user_id`,
 `user_first_name`, 
 `user_last_name`, 
 `user_lastlogin`, 
 `user_image` FROM 
 `app_users` WHERE
 `user_email`=? OR CONCAT(`user_first_name`, ' ', `user_last_name`) LIKE ?
 ORDER BY CONCAT(`user_first_name`, ' ', `user_last_name`) ASC");
$stmt->execute(array($quere,"%$quere%"));
$users = $stmt->fetchall(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if ($count > 0){
    $response = successState('users',$users);
}else{
    $response = errorState(404, 'no_users_found', 'No users found.');
}
echo json_encode($response,JSON_PRETTY_PRINT);