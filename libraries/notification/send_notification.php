<?php
include "fcm.php";

$title = postRequest('title');
$message = postRequest('message');
$topic = postRequest('topic');
$data = postRequest('data');

$dataEncoded = json_decode($data);
sendGCM($title, $message, $topic, $dataEncoded);