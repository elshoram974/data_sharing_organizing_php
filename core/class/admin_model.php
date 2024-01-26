<?php

class Admin
{
    public int $id;
    public string $firstName;
    public string $lastName;
    public string $email;
    public string $password;
    public ?string $verificationCode;
    public DateTime $lastLogin;
    public DateTime $createdAt;

    public function __construct(
        int $id,
        string $firstName,
        string $lastName,
        string $email,
        string $password,
        ?string $verificationCode,
        DateTime $lastLogin,
        DateTime $createdAt,
    ) {
        $this->id = $id;
        $this->firstName = $firstName;
        $this->lastName = $lastName;
        $this->email = $email;
        $this->password = $password;
        $this->verificationCode = $verificationCode;
        $this->lastLogin = $lastLogin;
        $this->createdAt = $createdAt;
    }

    public static function fromArray(array $data): self
    {
        // Convert the date strings to DateTime objects
        $lastLogin = new DateTime($data['a_last_login']);
        $createdAt = new DateTime($data['a_create_at']);

        return new self(
            id: $data['a_id'],
            firstName: $data['a_first_name'],
            lastName: $data['a_last_name'],
            email: $data['a_email'],
            password: $data['a_password'],
            verificationCode: $data['a_verified_code'],
            lastLogin: $lastLogin,
            createdAt: $createdAt,
        );
    }

    public function toArray(): array
    {
        return [
            'a_id' => $this->id,
            'a_first_name' => $this->firstName,
            'a_last_name' => $this->lastName,
            'a_email' => $this->email,
            'a_password' => $this->password,
            'a_verified_code' => $this->verificationCode,
            'a_last_login' => $this->lastLogin->format('Y-m-d H:i:s'),
            'a_create_at' => $this->createdAt->format('Y-m-d H:i:s'),
        ];
    }
}
