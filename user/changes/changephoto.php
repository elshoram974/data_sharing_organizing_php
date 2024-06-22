<?php

include "../../connect.php";
$dir = "../../assets/users_photo/";

$user_id = postRequest("user_id");
$image = file_upload("file", false);
$Link = 'https://thiet.mrecode.com/api/assets/users_photo/' . $image;

if ($image == 'ext') {
    $response = errorState(415, 'unsupported-media-type', 'This file is not support');
} elseif ($image == 'size') {
    $response = errorState(413, 'payload-too-large', 'This file is larg in size');
} else {
    $Stmt = $con->prepare("SELECT app_users.user_image FROM app_users WHERE user_id = ?");
    $Stmt->execute(array($user_id));
    $old_image = $Stmt->fetch(PDO::FETCH_ASSOC);
    if (count($old_image) > 0 && $old_image['user_image'] != '') {
        delete_file($dir, end(explode('/', $old_image['user_image'])));
        $updateStmt = $con->prepare("UPDATE app_users SET user_image = ? WHERE user_id = ?");
        $updateStmt->execute(array($Link, $user_id));
    } else {
        $updateStmt = $con->prepare("UPDATE app_users SET user_image = ? WHERE user_id = ?");
        $updateStmt->execute(array($Link, $user_id));
    }

    $selectStmt = $con->prepare("SELECT app_users.* FROM app_users WHERE user_id = ?");
    $selectStmt->execute(array($user_id));
    $data = $selectStmt->fetch(PDO::FETCH_ASSOC);
    $response = successState('user', $data);

    $action_type = "account_crud";
    $action_details = "user is changed image";
    action($user_id, $action_type, $action_details, $con);
}
echo json_encode($response, JSON_PRETTY_PRINT);