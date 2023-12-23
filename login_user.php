<?php
include("connect.php");

// login api

try {
    global $email;
    global $password;

    $email = $_POST['email'];
    $password = $_POST['password'];
    if (empty($email) || empty($password)) throw new Exception("you have to fill post fields");
} catch (Exception $e) {
    echo json_encode(errorState(400, $e->getMessage()));
    exit;
}

$stmt = $con->prepare("SELECT * FROM `users` WHERE `user_email` = ?");

$stmt->execute(array($email));
$count = $stmt->rowCount();

if ($count > 0) {

    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user['user_password'] == $password) {
        if ($user['user_is_verified'] == 1) {
            $response = successState('user', $user);
        } else {
            $response = errorState(401, 'you have to confirm your account');
        }
    } else {
        $response = errorState(401, 'Error in password');
    }
} else {
    $response = errorState(401, 'Error in email');
}

header('Content-Type: application/json');
echo json_encode($response);
