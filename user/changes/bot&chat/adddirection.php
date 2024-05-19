<?php

include "../../../connect.php";
$user_id = postRequest("user_id");
$group_id = postRequest("group_id");
$dir_address =postRequest("address");
$max_activity = postRequest("max_activity");
$inside_dir_id =postRequest("inside_dir_id",true);

if(empty($inside_dir_id)){
    $inside_dir_id = NULL;
}

$state1Stmt = $con->prepare("SELECT member_is_admin FROM group_members WHERE member_id = ? AND  group_id = ?");
$state1Stmt->execute(array($user_id , $group_id));
$userstatus = $state1Stmt->fetchAll(PDO::FETCH_ASSOC);
if ($userstatus[0]['member_is_admin'] == 1){
    $addstmt = $con->prepare("INSERT INTO `group_activity_direction`
    (`group_id`,
     `direction_address`,
     `direction_max_count_activity`,
     `inside_direction_id`,
     `direction_is_approved`, 
     `direction_owner_id`) VALUES
     (?,?,?,?,?,?) ");
    $addstmt->execute(array($group_id, $dir_address, $max_activity, $inside_dir_id, 1, $user_id));
    $selectstmt = $con->prepare("SELECT `direction_id` FROM `group_activity_direction` ORDER BY `direction_id` DESC LIMIT 1");
    $selectstmt -> execute();
    $result = $selectstmt->fetch(PDO::FETCH_ASSOC);
    $response = successState('response', ['direction_is_approved' => 1 ,'direction_id' => $result['direction_id']]);
}else{
    $state2Stmt = $con->prepare("SELECT group_access_type FROM group_deails WHERE group_id = ?");
    $state2Stmt->execute(array($group_id));
    $groupstatus = $state2Stmt->fetchAll(PDO::FETCH_ASSOC);
    if($groupstatus[0]['group_access_type'] == 'only_read'){
        $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
    }
    elseif($groupstatus[0]['group_access_type'] == 'read_write'){
        $stmt = $con->prepare("SELECT `member_can_interaction` FROM `group_members` WHERE `member_id` =? AND `group_id` =?");
        $stmt->execute(array($user_id, $group_id));
        $interaction = $stmt->fetch(PDO::FETCH_ASSOC);
        if($interaction['member_can_interaction'] == 1){
            $addstmt = $con->prepare("INSERT INTO `group_activity_direction`
            (`group_id`,
            `direction_address`,
            `direction_max_count_activity`,
            `inside_direction_id`,
            `direction_is_approved`, 
            `direction_owner_id`) VALUES
            (?,?,?,?,?,?) ");
            $addstmt->execute(array($group_id, $dir_address, $max_activity, $inside_dir_id, 1, $user_id));
            $selectstmt = $con->prepare("SELECT `direction_id` FROM `group_activity_direction` ORDER BY `direction_id` DESC LIMIT 1");
            $selectstmt -> execute();
            $result = $selectstmt->fetch(PDO::FETCH_ASSOC);
            $response = successState('response', ['direction_is_approved' => 1 ,'direction_id' => $result['direction_id']]);
        }else{
                $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
        }
    }else{
        $stmt = $con->prepare("SELECT `member_can_interaction` FROM `group_members` WHERE `member_id` =? AND `group_id` =?");
        $stmt->execute(array($user_id, $group_id));
        $interaction = $stmt->fetch(PDO::FETCH_ASSOC);
        if($interaction['member_can_interaction'] == 1){
            $addstmt = $con->prepare("INSERT INTO `group_activity_direction`
            (`group_id`,
            `direction_address`,
            `direction_max_count_activity`,
            `inside_direction_id`,
            `direction_is_approved`, 
            `direction_owner_id`) VALUES
            (?,?,?,?,?,?) ");
            $addstmt->execute(array($group_id, $dir_address, $max_activity, $inside_dir_id, 0, $user_id));
            $selectstmt = $con->prepare("SELECT `direction_id` FROM `group_activity_direction` ORDER BY `direction_id` DESC LIMIT 1");
            $selectstmt -> execute();
            $result = $selectstmt->fetch(PDO::FETCH_ASSOC);
            $response = successState('response', ['direction_is_approved' => 1 ,'direction_id' => $result['direction_id']]);
        }else{
            $response = errorState(403, 'access_denied', 'User does not have permission to perform this action.');
        }

    }
}

echo json_encode($response);
