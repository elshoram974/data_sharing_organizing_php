<?php
include("../../connect.php");

// login api

try {
    global $email;
    global $password;

    $email = $_POST['email'];
    $password = $_POST['password'];

    if (empty($email) || empty($password)) {
        throw new Exception("Email or password is empty. Email: $email, Password: $password");
    }
} catch (Exception $e) {
    echo json_encode(errorState(400, $e->getMessage()));
    exit;
}


$stmt = $con->prepare("SELECT * FROM `app_users` WHERE `user_email` = ?");
$stmt->execute(array($email));

$count = $stmt->rowCount();

if ($count > 0) {
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    // Hash the provided password and compare it with the stored hash
    if ($password == $user['user_password']) {
        // if (password_verify($password, $user['user_password'])) {
        if ($user['user_is_verified'] == 1) {
            // Save login time in the database
            $loginTime = date('Y-m-d H:i:s');
            $updateStmt = $con->prepare("UPDATE `app_users` SET `account_lastlogin` = ? WHERE `user_id` = ?");
            $updateStmt->execute(array($loginTime, $user['user_id']));

            $user['account_lastlogin'] = $loginTime;

            $response = successState('user', $user);
        } else {
            $response = errorState(401, 'You have to confirm your account');
        }
    } else {
        $response = errorState(401, 'Error in password');
    }
} else {
    $response = errorState(401, 'the email you entered is not exist');
}

header('Content-Type: application/json');
echo json_encode($response);
