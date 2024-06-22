<?php

include "../../../connect.php";
$dir = "../../../assets/groups_files/";
$user_id = postRequest("user_id");
$group_name = postRequest("name");
$group_description = postRequest("description", true);
$group_visibility = postRequest("visibility", true);
$group_access_type = postRequest("access_type", true);
$group_category = postRequest("category");
$group_image = file_upload("image", false);
$group_type = postRequest("type", true);
$group_discussion_type = postRequest("discussion_type");
$group_status = postRequest("status", true);
$group_status_message = postRequest("status_message", true);
if (empty($group_description)) {
    $group_description = NULL;
}
if (empty($group_visibility)) {
    $group_visibility = "public";
}
if (empty($group_access_type)) {
    $group_access_type = "read_write_with_admin_permission";
}
if (empty($group_type)) {
    $group_type = "public";
}
if (empty($group_status)) {
    $group_status = "active";
}
if (empty($group_status_message)) {
    $group_status_message = NULL;
}
if (isset($group_image)) {
    $Link = 'https://thiet.mrecode.com/api/assets/groups_files/' . $group_image;
} else {
    $Link = null;
}
$addstmt = $con->prepare("INSERT INTO `group_deails`
(`group_name`,
 `group_owner_id`, 
 `group_description`, 
 `group_visibility`, 
 `group_access_type`, 
 `group_category`, 
 `group_image`, 
 `group_type`, 
 `group_discussion_type`, 
 `group_status`, 
 `group_status_message`) VALUES
 (?,?,?,?,?,?,?,?,?,?,?)");
$addstmt->execute(array($group_name, $user_id, $group_description, $group_visibility, $group_access_type, $group_category, $Link, $group_type, $group_discussion_type, $group_status, $group_status_message));

$groupStmt =  $con->prepare('SELECT * FROM `group_deails` ORDER BY `group_id` DESC LIMIT 1');
$groupStmt->execute();
$result = $groupStmt->fetch(PDO::FETCH_ASSOC);
$response = successState('group', $result);
$group_id = $result['group_id'];

$adminstmt = $con->prepare("INSERT INTO `group_members`(`group_id`, `member_id`,`member_is_admin`) VALUES (?,?,?)");
$adminstmt->execute(array($group_id, $user_id, 1));

$list_users = postRequest("list_users_id", true);
$data = json_decode($list_users);

if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode($response, JSON_PRETTY_PRINT);
} else {
    foreach ($data as $value) {
        $add2stmt = $con->prepare('INSERT INTO `group_members`(`group_id`, `member_id`) VALUES (?,?)');
        $add2stmt->execute(array($group_id, $value));
    }
    echo json_encode($response, JSON_PRETTY_PRINT);
}