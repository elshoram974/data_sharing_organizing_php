<?php

include "../../connect.php";
$dir = "../../assets/users_photo/";

$user_id = postRequest("user_id");

$Stmt = $con->prepare("SELECT app_users.user_image FROM app_users WHERE user_id = ?");
$Stmt->execute(array($user_id));
$old_image = $Stmt->fetch(PDO::FETCH_ASSOC);
if (count($old_image) > 0 && $old_image['user_image'] != '') {
        delete_file($dir , end(explode('/', $old_image['user_image'])));
        $updateStmt = $con->prepare("UPDATE app_users SET user_image = NULL WHERE user_id = ?");
        $updateStmt->execute(array($user_id));
        
        $selectStmt = $con->prepare("SELECT app_users.* FROM app_users WHERE user_id = ?");
        $selectStmt->execute(array($user_id));
        $data = $selectStmt->fetch(PDO::FETCH_ASSOC);
        $response = successState('user', $data);

        $action_type = "account_crud";
        $action_details = "user is deleted image";
        action($user_id, $action_type, $action_details, $con);

} else {
    $response = errorState(404, 'not-found', 'this user is not put image');
}

echo json_encode($response, JSON_PRETTY_PRINT);
