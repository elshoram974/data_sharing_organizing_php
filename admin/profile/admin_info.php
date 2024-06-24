<?php
include "../../connect.php";

$admin_id=postRequest("admin_id");


$stmt=$con->prepare
("SELECT * FROM admins WHERE a_id=?");
$stmt->execute(array($admin_id));
$info=$stmt->fetch(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();
if($count != 0){
    $response = successState("admin_information", $info );
    echo json_encode($response, JSON_PRETTY_PRINT);
}else{
    $errorResponse = errorState(404, 'no_user_found', 'No user found.');
    echo json_encode($errorResponse);
}
