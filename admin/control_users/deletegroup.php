<?php
include "../../connect.php";

$group_id = postRequest("g_id");


$deleteStmt = $con->prepare('DELETE FROM group_members WHERE group_id = ?;
UPDATE `group_deails` SET `group_status`= ? WHERE `group_id`= ?');
$deleteStmt->execute(array($group_id,"deleted",$group_id));

if(($deleteStmt->rowCount()) > 0){
    $response = successState('response', ['massege' => 'group has been deleted successfully']);
}else{
    $response = errorState(500, 'sql_query_failure', 'deleted failed try again.');
}

echo json_encode($response, JSON_PRETTY_PRINT);