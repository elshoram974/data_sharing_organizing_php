<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Credentials: true');
header('Content-Type: application/json');

$dbname = "data_sharing_organizing";
$user = "thiet";
$pass = "thiet2024";



$dsn = "mysql:host=localhost;dbname=$dbname;";

$options = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8");

date_default_timezone_set('Africa/Cairo');


try {
    $con = new PDO($dsn, $user, $pass, $options);
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    include("core/functions/import.php");
} catch (\Throwable $th) {
    http_response_code($th->getCode());
    echo json_encode(array('status' => 'Failure', "code" => $th->getCode(), "type" => 'server-error', "message" => $th->getMessage()));
}
