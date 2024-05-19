<?php

function sendGCM(string $title, string $message, string $topic, ?string $data)
{


    $url = 'https://fcm.googleapis.com/fcm/send';

    $fields = array(
        "to" => '/topics/' . $topic,
        'priority' => 'high',
        'content_available' => true,

        'notification' => array(
            "body" =>  $message,
            "title" =>  $title,
            "click_action" => "FLUTTER_NOTIFICATION_CLICK",
            "sound" => "default"

        ),
        'data' => array(
            "data" => $data
        )



    );


    $fields = json_encode($fields);
    $headers = array(
        'Authorization: key=' . "AAAAbLVdcFU:APA91bHlT5QU-O2niatXjFVqEGCzJvVk8ltgKg6y3gVQzvyQNq1EDHIWgr4xFSeWrvY20r9gvg1rDKUneCLk_-VW6lg_1V-9ighrNm4F42JbFZiGj2-2ERee3rBeGPvI0yQYAvrjmMao",
        'Content-Type: application/json'
    );

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);

    $result = curl_exec($ch);
    curl_close($ch);
    return $result;
}