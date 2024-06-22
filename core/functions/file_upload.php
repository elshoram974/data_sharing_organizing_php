<?php

define('mb', 1048576);
function file_upload($file_request, bool $addAnyFile)
{
    if (isset($_FILES[$file_request])) {
        global $dir;
        global $msgerror;
        $filename  = rand(1, 100000) . $_FILES[$file_request]['name'];
        $filetmp   = $_FILES[$file_request]['tmp_name'];
        $filesize  = $_FILES[$file_request]['size'];
        $allow_ext  = array('jpg', 'jpeg', 'png', 'gif');
        $str_to_arr = explode('.', $filename);
        $ext        = end($str_to_arr);
        $ext        = strtolower($ext);

        if (!empty($filename) && !in_array($ext, $allow_ext) && !$addAnyFile) {
            $msgerror = 'ext';
        }
        if ($filesize > 500 * mb) {
            $msgerror = 'size';
        }
        if (empty($msgerror)) {
            move_uploaded_file($filetmp, $dir . $filename);
            return $filename;
        } else {
            throw new Exception($msgerror, 1);
        }
    } else {
        return null;
    }
}