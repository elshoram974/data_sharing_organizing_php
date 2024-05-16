<?php
include "../../core/functions/post_request.php";
include "fcm.php";
$title = postRequest('title');
$message = postRequest('message');
$topic = postRequest('topic');
$data = postRequest('data', true);

$result = sendGCM($title, $message, $topic, $data);
echo json_encode(array("result" => $result));