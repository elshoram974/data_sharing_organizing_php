<?php
function loginToUser(PDO $con, User $user, string $password, string $provider): array
{
    if ($user->provider != $provider) return errorState(401, 'User created by another provider');

    if (password_verify($password, $user->password)) {

        if (!$user->isVerified) sendUserVerifyEmail($con, $user, verificationType::createEmail);

        $user->lastLogin = new DateTime(updateLastLogin($con, $user->id));
        return successState('user', $user->toArray());
    }
    return errorState(401, 'Error in password');
}
function createNewUser(PDO $con, ?string $name, string $email, string $password, string $provider, string $userRole, bool $userIsVerified = false): User
{
    $nameParts = explode(' ', $name ?? 'No Name');
    $firstName = $nameParts[0];
    $lastName = trim(implode(' ', array_slice($nameParts, 1)));

    $stmt = $con->prepare("INSERT INTO `app_users`(`user_email`, `user_password`, `user_first_name`, `user_last_name`, `user_provider`, `user_role`, `user_is_verified`, `user_lastlogin`, `user_createdat`) VALUES (?,?,?,?,?,?,?,?,?)");
    $stmt->execute([$email, makeHashPassword($password), $firstName, $lastName, $provider, $userRole, $userIsVerified, date('Y-m-d H:i:s'), date('Y-m-d H:i:s')]);

    $stmt = selectFromAppUserByEmail($email, $con);
    $array = $stmt->fetch(PDO::FETCH_ASSOC);
    return  User::fromArray($array);
}
