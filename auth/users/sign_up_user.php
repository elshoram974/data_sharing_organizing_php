<?php
include("../../connect.php");
include("../../core/class/app_user/app_user_model.php");
include("../../core/class/verification/verification_type_enum.php");


$name = postRequest('name', true);
$email = postRequest('email');
$password = postRequest('password');
$userRole = postRequest('userRole');

$stmt = selectFromAppUserByEmail($email, $con);
$count = $stmt->rowCount();

if ($count == 0) {

    if (strlen($password) >= 8) {


        $user = createNewUser(con: $con, name: $name, email: $email, password: $password, provider: UserProvider::emailPassword, userRole: $userRole, userIsVerified: false);
        sendUserVerifyEmail($email, verificationType::createEmail);

        $response = successState('user', $user->toArray());
    } else {
        $response = errorState(400, 'The password is very weak');
    }
} else {
    $response = errorState(409, 'This email already exists');
}

echo json_encode($response);
