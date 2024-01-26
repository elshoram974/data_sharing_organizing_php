<?php
include("../../connect.php");
include("../../core/class/app_user/app_user_model.php");

$name = postRequest('name', true);
$email = postRequest('email');
$provider = postRequest('provider');

$stmt = selectFromAppUserByEmail($email, $con);

$count = $stmt->rowCount();

if ($count > 0) {
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    $user =  User::fromArray($array);

    if ($user->password != 'User created by another provider' || $user->provider != $provider) {
        $response = errorState(401, 'User created by another provider');
    } else {
        $user->lastLogin = new DateTime(updateLastLogin($con, $user->id));
        $response = successState('user', $user->toArray());
    }
} else {
    $nameParts = explode(' ', $name ?? 'No Name');
    $firstName = $nameParts[0];
    $lastName = trim(implode(' ', array_slice($nameParts, 1)));

    $stmt = $con->prepare("INSERT INTO `app_users`(`user_email`, `user_first_name`, `user_last_name`, `user_provider`, `user_role`, `user_is_verified`) VALUES (?,?,?,?,?,?)");
    $stmt->execute([$email, $firstName, $lastName, $provider, 'personal_user', 1]);

    $stmt = selectFromAppUserByEmail($email, $con);
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    $user =  User::fromArray($array);

    $response = successState('user', $user->toArray());
}

echo json_encode($response);
