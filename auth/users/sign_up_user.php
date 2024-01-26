<?php
include("../../connect.php");
include("../../core/class/app_user/app_user_model.php");


$name = postRequest('name', true);
$email = postRequest('email');
$password = postRequest('password');
$userRole = postRequest('userRole');

$stmt = selectFromAppUser($email, $con);
$count = $stmt->rowCount();

if ($count == 0) {

    if (strlen($password) >= 8) {

        $nameParts = explode(' ', $name ?? 'No Name');
        $firstName = $nameParts[0];
        $lastName = trim(implode(' ', array_slice($nameParts, 1)));

        $stmt = $con->prepare("INSERT INTO `app_users`(`user_email`, `user_first_name`, `user_last_name`, `user_password`, `user_provider`, `user_role`) VALUES (?,?,?,?,?,?)");
        $stmt->execute([$email, $firstName, $lastName, makeHashPassword($password), 'email_password', $userRole]);

        $stmt = selectFromAppUser($email, $con);
        $array = $stmt->fetch(PDO::FETCH_ASSOC);
        $user =  User::fromArray($array);

        sendUserVerifyEmail($email);


        $response = successState('user', $user->toArray());
    } else {
        $response = errorState(400, 'The password is very weak');
    }
} else {
    $response = errorState(409, 'This email already exists');
}

echo json_encode($response);
