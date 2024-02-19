<?php
include("../../connect.php");
include("../../core/class/app_user/app_user_model.php");
include("../../core/class/verification/verification_type_enum.php");


$email = postRequest('email');
$password = postRequest('password');

$stmt = selectFromAppUserByEmail($email, $con);

$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);

    $user =  User::fromArray($array);
    $response = loginToUser(con: $con, user: $user, password: $password, provider: UserProvider::emailPassword);
} else {
    $response = errorState(401, 'auth-error', 'The email you entered does not exist');
}

echo json_encode($response);
