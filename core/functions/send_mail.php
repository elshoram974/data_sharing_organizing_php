<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;


function sendMail(string $toEmail, string $toName = '', string $subject, string $body): void
{
    require "../../libraries/phpmailer/Exception.php";
    require "../../libraries/phpmailer/PHPMailer.php";
    require "../../libraries/phpmailer/SMTP.php";
    $mail = new PHPMailer(true);
    try {
        //Server settings
        $mail->SMTPDebug = SMTP::DEBUG_OFF;
        $mail->isSMTP();
        $mail->Host       = 'mail.mrecode.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'sharikna@mrecode.com';
        $mail->Password   = 'thiet2024#@';
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
        $mail->Port       = 465;

        //Recipients
        $mail->setFrom('sharikna@mrecode.com', 'Sharikna');
        $mail->addAddress($toEmail, $$toName);

        //Content
        $mail->isHTML(true);
        $mail->Subject = $subject;
        $mail->Body    = $body;
        // $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

        $mail->Priority = 1;

        $mail->send();
    } catch (Exception $e) {
        echo json_encode(errorState(500, 'mail-error', "Message could not be sent. Mailer Error: {$mail->ErrorInfo}"));
        die;
    }
}