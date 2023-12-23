<?php

// include '../../connect.php';

// try {
//     global $email;
//     $email = filterRequest('email');
//     global $verified_code;
//     $verified_code = filterRequest('verified_code');
// } catch (\Throwable $th) {
//     failureStatus('error when get post');
//     return;
// }



// $stmt = getUserByEmail($email, $con);
// if ($stmt->rowCount() > 0) {
//     $user = $stmt->fetch();

//     if ($user['verified_code'] == $verified_code) {
//         $stmt =  $con->prepare("UPDATE `users` SET `is_verified`= ? , verified_code = NULL , `last_login`= CURRENT_TIMESTAMP WHERE `email` = ?");
//         $stmt->execute(array(1, $email));
//         $stmt = getUserByEmail($email, $con);

//         successStatus($stmt->fetch(PDO::FETCH_ASSOC));
//     } else {
//         failureStatus('wrong code');
//     }
// } else {
//     failureStatus('email not exist');
// }
