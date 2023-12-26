<?php
$dbname = "data_sharing_organizing";
$user = "thiet";
$pass = "thiet2024";



$dsn = "mysql:host=localhost;dbname=$dbname;";

$options = array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8");

date_default_timezone_set('Africa/Cairo');


try {
    $con = new PDO($dsn, $user, $pass, $options);
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    include("functions/import.php");
} catch (\Throwable $th) {
    // failureStatus($th->getMessage());
}
