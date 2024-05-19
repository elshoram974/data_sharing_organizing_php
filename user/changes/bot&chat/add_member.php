<?php
include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest('group_id');
$list_users = postRequest("list_users_id");
$data = json_decode($list_users);

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);

if ($userstatus[0]['member_is_admin'] == 0) {
    $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    echo json_encode($response);
    exit;
}else{
    if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
        $errorResponse = errorState(400, 'error_json', 'Invalid JSON data');
        echo json_encode($errorResponse);
        exit();
    }else{
        $state2Stmt = $con->prepare("SELECT member_id FROM group_members WHERE group_id = ?");
        $state2Stmt->execute(array($group_id));
        $userstatus2 = $state2Stmt->fetchAll(PDO::FETCH_COLUMN);
        foreach ($data as $value) {
            if (!in_array($value, $userstatus2)) {
                $add2stmt = $con->prepare('INSERT INTO `group_members`(`group_id`, `member_id`) VALUES (?,?)');
                $add2stmt->execute(array($group_id,$value));
            }
        }
        $response = successState('response', ['Successful addition']);
        echo json_encode($response ,JSON_PRETTY_PRINT );
    }
}