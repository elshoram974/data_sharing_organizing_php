<?php
include "../../connect.php";

$stmt = $con->prepare("SELECT count(user_id) AS `number_of_users` FROM app_users");
$stmt->execute();
$count=$stmt->fetch(PDO::FETCH_ASSOC);
$response = successState("total_users_in_app", $count);

$stmt=$con->prepare("SELECT count(group_id) AS `number_of_groups` FROM group_deails");
$stmt->execute();
$count=$stmt->fetch(PDO::FETCH_ASSOC);
$response["total_groups_in_app"] = $count;


$stmt=$con->prepare("SELECT count(action_id) AS `number_of_users` FROM user_action_history 
WHERE action_type='page_view' AND action_time >= DATE_SUB(NOW(), INTERVAL 1 MONTH) ;");
$stmt->execute();
$count=$stmt->fetch(PDO::FETCH_ASSOC);
$response["visits_last_month"] = $count;


$stmt=$con->prepare("SELECT count(action_id) AS `number_of_users` FROM user_action_history 
WHERE action_type='page_view' AND action_time >= DATE_SUB(NOW(), INTERVAL 1 WEEK) ;");
$stmt->execute();
$count=$stmt->fetch(PDO::FETCH_ASSOC);
$response["visits_last_week"] = $count;


$stmt=$con->prepare("SELECT count(action_id) AS `number_of_users` FROM user_action_history 
WHERE action_type='page_view' AND action_time >= DATE_SUB(NOW(), INTERVAL 24 HOUR) ;");
$stmt->execute();
$count=$stmt->fetch(PDO::FETCH_ASSOC);
$response["visits_last_day"] = $count;

echo json_encode($response, JSON_PRETTY_PRINT);
