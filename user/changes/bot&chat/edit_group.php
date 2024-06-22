<?php
include "../../../connect.php";
$dir = "../../../assets/groups_files/";
$user_id = postRequest("user_id");
$group_id = postRequest('group_id');
$group_name = postRequest("name", true);
$group_image = file_upload("image", false);

if (empty($group_name)) {
    $group_name = null;
}

if (isset($group_image)) {
    $Link = 'https://thiet.mrecode.com/api/assets/groups_files/' . $group_image;
} else {
    $Link = null;
}

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id, $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);

if ($userstatus[0]['member_is_admin'] == 0) {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
} else {
    if ($group_name != null) {
        $updateGroupNameStmt = $con->prepare("UPDATE `group_deails` SET `group_name`= ? WHERE `group_id`= ? ");
        $updateGroupNameStmt->execute(array($group_name, $group_id));
    }
    if ($group_image != null) {
        $checkstmt = $con->prepare("SELECT `group_image` FROM `group_deails` WHERE `group_id` = ?");
        $checkstmt->execute(array($group_id));
        $oldImage = $checkstmt->fetch(PDO::FETCH_ASSOC);
        if (isset($old_image)) {
            delete_file($dir, end(explode('/', $old_image['group_image'])));
        }
        $updateGroupimageStmt = $con->prepare("UPDATE `group_deails` SET `group_image`= ? WHERE `group_id`= ? ");
        $updateGroupimageStmt->execute(array($Link, $group_id));
    }
}
$stmt = $con->prepare("SELECT * FROM `group_deails` WHERE `group_id` = ?");
$stmt->execute(array($group_id));
$row = $stmt->fetch(PDO::FETCH_ASSOC);
$response = successState('group', $row);
echo json_encode($response, JSON_PRETTY_PRINT);