<?php
include("../../connect.php");


$email = postRequest('email');
$password = postRequest('password');


$stmt = $con->prepare("SELECT * FROM `app_users` WHERE `user_email` = ?");
$stmt->execute(array($email));

$count = $stmt->rowCount();

if ($count > 0) {
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    // Hash the provided password and compare it with the stored hash
    if (password_verify($password, $user['user_password'])) {

        $user['account_lastlogin'] = updateLastLogin($con, $user['user_id']);
        $response = successState('user', $user);
    } else {
        $response = errorState(401, 'Error in password');
    }
} else {
    $response = errorState(401, 'The email you entered does not exist');
}

header('Content-Type: application/json');
echo json_encode($response);
