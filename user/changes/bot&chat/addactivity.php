<?php

include "../../../connect.php";

$dir = "../../../assets/groups_files/";

$user_id = postRequest('user_id');
$group_id = postRequest('activity_group_id');
$activity_type = postRequest('activity_type');
$activity_content = postRequest('activity_content', true);
$dir_id = postRequest('activity_direction_id', true);
$reply_on = postRequest('activity_reply_on', true);
$size = postRequest('activity_attachments_size', true);
$height = postRequest('activity_attachments_height', true);
$width = postRequest('activity_attachments_width', true);
$mimetype = postRequest('activity_attachments_mimetype', true);
$url = file_upload('file_request', true);

if (isset($url)) {
    $Link = 'https://thiet.mrecode.com/api/assets/groups_files/' . $url;
} else {
    $Link = null;
}
if (empty($activity_content)) {
    $activity_content = NULL;
}
if (empty($dir_id)) {
    $dir_id = NULL;
}
if (empty($reply_on)) {
    $reply_on = NULL;
}
if (empty($url)) {
    $url = NULL;
}
if (empty($height)) {
    $height = NULL;
}
if (empty($width)) {
    $width = NULL;
}

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id, $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);
if ($userstatus[0]['member_is_admin'] == 1) {
    $addstmt = $con->prepare("INSERT INTO `group_activity`
        (`activity_group_id`,
         `activity_direction_id`,
         `activity_type`,
         `activity_reply_on`,
         `activity_content`, 
         `activity_attachments_url`,
         `activity_attachments_size`,
         `activity_attachments_height`,
         `activity_attachments_width`,
         `activity_attachments_mimetype`,
         `activity_is_approved`,
         `activity_owner_id`) VALUES
         (?,?,?,?,?,?,?,?,?,?,?,?)");
    $addstmt->execute(array($group_id, $dir_id, $activity_type, $reply_on, $activity_content, $Link, $size, $height, $width, $mimetype, 1, $user_id));
    $response = successState('response', ['activity_is_approved' => 1]);
} else {
    $state2Stmt = $con->prepare("SELECT group_access_type FROM group_deails WHERE group_id = ?");
    $state2Stmt->execute(array($group_id));
    $groupstatus = $state2Stmt->fetchAll(PDO::FETCH_ASSOC);
    if ($groupstatus[0]['group_access_type'] == 'only_read') {
        $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    } elseif ($groupstatus[0]['group_access_type'] == 'read_write') {
        $stmt = $con->prepare("SELECT `member_can_interaction` FROM `group_members` WHERE `member_id` =? AND `group_id` =?");
        $stmt->execute(array($user_id, $group_id));
        $interaction = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($interaction['member_can_interaction'] == 1) {
            $addstmt = $con->prepare("INSERT INTO `group_activity`
            (`activity_group_id`,
            `activity_direction_id`,
            `activity_type`,
            `activity_reply_on`,
            `activity_content`, 
            `activity_attachments_url`,
            `activity_attachments_size`,
            `activity_attachments_height`,
            `activity_attachments_width`,
            `activity_attachments_mimetype`,
            `activity_is_approved`,
            `activity_owner_id`) VALUES
            (?,?,?,?,?,?,?,?,?,?,?,?)");
            $addstmt->execute(array($group_id, $dir_id, $activity_type, $reply_on, $activity_content, $Link, $size, $height, $width, $mimetype, 1, $user_id));
            $response = successState('response', ['activity_is_approved' => 1]);
        } else {
            $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
        }
    } else {
        $stmt = $con->prepare("SELECT `member_can_interaction` FROM `group_members` WHERE `member_id` =? AND `group_id` =?");
        $stmt->execute(array($user_id, $group_id));
        $interaction = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($interaction['member_can_interaction'] == 1) {
            $addstmt = $con->prepare("INSERT INTO `group_activity`
            (`activity_group_id`,
            `activity_direction_id`,
            `activity_type`,
            `activity_reply_on`,
            `activity_content`, 
            `activity_attachments_url`,
            `activity_attachments_size`,
            `activity_attachments_height`,
            `activity_attachments_width`,
            `activity_attachments_mimetype`,
            `activity_is_approved`,
            `activity_owner_id`) VALUES
            (?,?,?,?,?,?,?,?,?,?,?,?)");
            $addstmt->execute(array($group_id, $dir_id, $activity_type, $reply_on, $activity_content, $Link, $size, $height, $width, $mimetype, 0, $user_id));
            $response = successState('response', ['activity_is_approved' => 0]);
        } else {
            $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
        }
    }
}

echo json_encode($response);