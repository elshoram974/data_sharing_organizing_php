<?php
include "../../connect.php";

$admin_id=postRequest("admin_id");
$first_name=postRequest("new_first_name",true);
$last_name=postRequest("new_last_name",true);
$email=postRequest("new_email",true);
$old_password=postRequest("old_password",true);
$new_password=postRequest("new_password",true);

$stmt=$con->prepare
("SELECT * FROM admins WHERE a_id=?");
$stmt->execute(array($admin_id));
$info=$stmt->fetch(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();
if($count == 0){
    $errorResponse = errorState(404, 'no_user_found', 'No user found.');
    echo json_encode($errorResponse);
    exit();
}

if(!empty($first_name)){
    $stmt=$con->prepare
    ("UPDATE `admins` SET `a_first_name`=? where `a_id`=?");
    $stmt->execute(array($first_name,$admin_id));
}

if(!empty($last_name)){
    $stmt=$con->prepare
    ("UPDATE `admins` SET `a_last_name`=? where `a_id`=?");
    $stmt->execute(array($last_name,$admin_id));
}

if(!empty($email)){
    $stmt=$con->prepare
    ("UPDATE `admins` SET `a_email`=? where `a_id`=?");
    $stmt->execute(array($email,$admin_id));
}

if(!empty($old_password)&&!empty($new_password)){
    $stmt=$con->prepare
    ("SELECT * FROM admins WHERE a_id=?");
    $stmt->execute(array($admin_id));
    $password=$stmt->fetch(PDO::FETCH_ASSOC);

    if($password["a_password"]==$old_password){
    $stmt=$con->prepare
    ("UPDATE `admins` SET `a_password`=? where `a_id`=?");
    $stmt->execute(array($new_password,$admin_id));}
}

$stmt=$con->prepare
("SELECT * FROM admins WHERE a_id=?");
$stmt->execute(array($admin_id));
$info=$stmt->fetch(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();
if($count != 0){
    $response = successState("admin_information", $info );
    echo json_encode($response, JSON_PRETTY_PRINT);
}