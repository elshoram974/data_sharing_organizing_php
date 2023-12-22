<?php
function successState(string $arrayName, array $successArray): array
{
    http_response_code(200);
    return array('status' => 'Success', $arrayName => $successArray);
}
function errorState(int $statusCode, string $message): array
{
    http_response_code($statusCode);
    return array('status' => 'Failure', "code" => $statusCode, "message" => $message);
}
