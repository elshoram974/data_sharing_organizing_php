<?php
function loginToUser(PDO $con, User $user, string $password, string $provider): array
{
    if ($user->provider != $provider) return errorState(401, 'auth-error', 'User created by another provider');

    if (password_verify($password, $user->password)) {

        if ($user->status == UserStatus::pending && $user->statusMessage == 'want to verify the account') sendUserVerifyEmail($con, $user, verificationType::createEmail);

        $user->lastLogin = new DateTime(updateLastLogin($con, $user->id));
        return successState('user', $user->toArray());
    }
    return errorState(401, 'auth-error', 'Error in password');
}
function createNewUser(PDO $con, ?string $name, string $email, string $password, string $provider, string $userType, string $userStatus = UserStatus::pending, ?string $userStatusMessage = 'want to verify the account'): User
{
    $nameParts = explode(' ', $name ?? 'No Name');
    $firstName = $nameParts[0];
    $lastName = trim(implode(' ', array_slice($nameParts, 1)));

    $stmt = $con->prepare("INSERT INTO `app_users`(`user_email`, `user_password`, `user_first_name`, `user_last_name`, `user_provider`, `user_type`, `user_status`, `user_status_message`, `user_lastlogin`, `user_createdat`) VALUES (?,?,?,?,?,?,?,?,?,?)");
    $stmt->execute([$email, makeHashPassword($password), $firstName, $lastName, $provider, $userType, $userStatus, $userStatusMessage, date('Y-m-d H:i:s'), date('Y-m-d H:i:s')]);

    $stmt = selectFromAppUserByEmail($email, $con);
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    return  User::fromArray($array);
}
