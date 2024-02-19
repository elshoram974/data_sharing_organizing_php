<?php
include("../../connect.php");
include("../../core/class/app_user/app_user_model.php");

$name = postRequest('name', true);
$email = postRequest('email');
$password = postRequest('password');
$provider = postRequest('provider');

$stmt = selectFromAppUserByEmail($email, $con);

$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    $user =  User::fromArray($array);

    $response = loginToUser(con: $con, user: $user, password: $password, provider: $provider);
} else {

    $user = createNewUser(con: $con, name: $name, email: $email, password: $password, provider: $provider, userType: UserType::personal, userStatus: UserStatus::active, userStatusMessage: null);

    $response = successState('user', $user->toArray());
}

echo json_encode($response);
