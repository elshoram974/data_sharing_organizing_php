<?php

abstract class UserProvider
{
    const facebook = 'facebook';
    const google = 'google';
    const emailPassword = 'email_password';
}

abstract class UserRole
{
    const personalUser = 'personal_user';
    const businessUser = 'business_user';

    const businessAdmin = 'business_admin';
}

// Class for User
class User
{
    public int $id;
    public string $firstName;
    public string $lastName;
    public string $email;
    public string $password;
    public string $provider;
    public bool $isVerified;
    public DateTime $lastLogin;
    public DateTime $createdAt;
    public ?string $image;
    public string $role;

    public function __construct(
        int $id,
        string $firstName,
        string $lastName,
        string $email,
        string $password,
        string $provider = UserProvider::emailPassword,
        bool $isVerified = false,
        DateTime $lastLogin,
        DateTime $createdAt,
        ?string $image,
        string $role,
    ) {
        $this->id = $id;
        $this->firstName = $firstName;
        $this->lastName = $lastName;
        $this->email = $email;
        $this->password = $password;
        $this->provider = $provider;
        $this->isVerified = $isVerified;
        $this->lastLogin = $lastLogin;
        $this->createdAt = $createdAt;
        $this->image = $image;
        $this->role = $role;
    }


    public static function fromArray(array $data): self
    {

        // Convert the date strings to DateTime objects
        $lastLogin = new DateTime($data['user_lastlogin']);
        $createdAt = new DateTime($data['user_createdat']);

        return new self(
            $data['user_id'],
            $data['user_first_name'],
            $data['user_last_name'],
            $data['user_email'],
            $data['user_password'],
            $data['user_provider'],
            $data['user_is_verified'] == 1 ? true : false,
            $lastLogin,
            $createdAt,
            $data['user_image'],
            $data['user_role'],
        );
    }

    public function toArray(): array
    {
        return
            array(
                'user_id' => $this->id,
                'user_first_name' => $this->firstName,
                'user_last_name' => $this->lastName,
                'user_email' => $this->email,
                'user_password' => $this->password,
                'user_provider' => $this->provider,
                'user_is_verified' => $this->isVerified,
                'user_lastlogin' => $this->lastLogin->format('Y-m-d H:i:s'),
                'user_createdat' => $this->createdAt->format('Y-m-d H:i:s'),
                'user_image' => $this->image,
                'user_role' => $this->role,
            );
    }
}
