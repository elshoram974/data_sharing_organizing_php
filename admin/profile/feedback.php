<?php
include "../../connect.php";

$stmt=$con->prepare
("SELECT * FROM help_and_support ");
$stmt->execute();
$info=$stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();
if($count != 0){
    $response = successState("help_and_support_information", $info );
    echo json_encode($response, JSON_PRETTY_PRINT);
}else{
    $response = array();
    echo json_encode($response);
}