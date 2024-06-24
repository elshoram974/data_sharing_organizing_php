<?php
include "../../../connect.php";
$dir = "../../../assets/groups_files/";
$user_id = postRequest("user_id");
$group_id = postRequest('group_id');

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);

if ($userstatus[0]['member_is_admin'] == 0) {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
} else {
    $checkstmt = $con->prepare("SELECT `group_image` FROM `group_deails` WHERE `group_id` = ?");
    $checkstmt->execute(array($group_id));
    $oldImage = $checkstmt->fetch(PDO::FETCH_ASSOC);

    if (isset($oldImage['group_image'])) {
        $old_image = $oldImage['group_image'];
        $image_parts = explode('/', $old_image);
        $image_name = end($image_parts);
        delete_file($dir, $image_name);

        $updateGroupimageStmt = $con->prepare("UPDATE `group_deails` SET `group_image`= ? WHERE `group_id`= ?");
        $updateGroupimageStmt->execute(array(NULL, $group_id));
        $response = successState('response', ['massege' => 'group image delelet successfully']);
    } else {
        $response = successState('response', ['massege' => 'does not image to group']);
    }
}

echo json_encode($response);
