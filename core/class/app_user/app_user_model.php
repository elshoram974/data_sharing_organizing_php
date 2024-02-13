<?php

abstract class UserProvider
{
    const facebook = 'facebook';
    const google = 'google';
    const emailPassword = 'email_password';
}

abstract class UserType
{
    const personal = 'personal';
    const business = 'business';

}

abstract class UserStatus
{
    const active = 'active';
    const inactive = 'inactive';
    const suspended = 'suspended';
    const deleted = 'deleted';
    const pending = 'pending';
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
    public DateTime $lastLogin;
    public DateTime $createdAt;
    public ?string $image;
    public string $type;
    public string $status;
    public ?string $statusMessage;


    public function __construct(
        int $id,
        string $firstName,
        string $lastName,
        string $email,
        string $password,
        string $provider = UserProvider::emailPassword,
        DateTime $lastLogin,
        DateTime $createdAt,
        ?string $image,
        string $type,
        string $status = UserStatus::pending,
        ?string $statusMessage,
    ) {
        $this->id = $id;
        $this->firstName = $firstName;
        $this->lastName = $lastName;
        $this->email = $email;
        $this->password = $password;
        $this->provider = $provider;
        $this->lastLogin = $lastLogin;
        $this->createdAt = $createdAt;
        $this->image = $image;
        $this->type = $type;
        $this->status = $status;
        $this->statusMessage = $statusMessage;
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
            $lastLogin,
            $createdAt,
            $data['user_image'],
            $data['user_type'],
            $data['user_status'],
            $data['user_status_message'],
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
                'user_lastlogin' => $this->lastLogin->format('Y-m-d H:i:s'),
                'user_createdat' => $this->createdAt->format('Y-m-d H:i:s'),
                'user_image' => $this->image,
                'user_type' => $this->type,
                'user_status' => $this->status,
                'user_status_message' => $this->statusMessage,
            );
    }
}
