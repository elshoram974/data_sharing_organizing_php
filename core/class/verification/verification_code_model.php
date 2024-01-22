<?php

include("verification_type_enum.php");


class VerificationCode
{
    public int $id;
    public int $userId;
    public string $code;
    public string $codeType;
    public DateTime $createDate;

    public function __construct(int $id, int $userId, string $code, string $codeType, DateTime $createDate)
    {
        $this->id = $id;
        $this->userId = $userId;
        $this->code = $code;
        $this->codeType = $codeType;
        $this->createDate = $createDate;
    }

    public static function fromJson(string $json): self
    {
        $data = json_decode($json, true);

        return new self(
            $data['verification_id'],
            $data['verification_user'],
            $data['verification_code'],
            $data['verification_type'],
            new DateTime($data['verification_created_at'])
        );
    }

    public function toJson(): string
    {
        return json_encode([
            'verification_id' => $this->id,
            'verification_user' => $this->userId,
            'verification_code' => $this->code,
            'verification_type' => $this->codeType,
            'verification_created_at' => $this->createDate->format('Y-m-d H:i:s'),
        ], JSON_PRETTY_PRINT);
    }
}
