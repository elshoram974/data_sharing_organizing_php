<?php
include "../../connect.php";

$admin_id = postRequest("a_id");


$deleteStmt = $con->prepare('DELETE FROM admins WHERE a_id  = ?');
$deleteStmt->execute(array($admin_id));

if(($deleteStmt->rowCount()) > 0){
    $response = successState('response', ['massege' => 'Admin has been deleted successfully']);
}else{
    $response = errorState(500, 'sql_query_failure', 'deleted failed try again.');
}

echo json_encode($response, JSON_PRETTY_PRINT);