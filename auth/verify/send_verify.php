<?php

// include '../../connect.php';

// try {
//     global $email;
//     global $title;
//     $email = filterRequest('email');
//     $title = filterRequest('title', true) ?? 'GPA PRO';
// } catch (\Throwable $th) {
//     failureStatus('error when get post');
//     return;
// }



// $stmt = getUserByEmail($email, $con);
// if ($stmt->rowCount() > 0) {

//     $rand = rand(100000, 999999);

//     $stmt =  $con->prepare("UPDATE `users` SET `verified_code`= ? WHERE `email` = ?");
//     $stmt->execute(array($rand, $email));
//     $stmt = getUserByEmail($email, $con);


//     sendCode($title, $email, $rand);
//     successStatus($stmt->fetch(PDO::FETCH_ASSOC));
// } else {
//     failureStatus('email not exist');
// }
