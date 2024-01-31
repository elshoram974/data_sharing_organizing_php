<?php
function postRequest(string $body, bool $canBeEmpty = false): ?string
{
    $post = $_POST[$body];
    if (!$canBeEmpty && empty($post)) {
        echo json_encode(errorState(400, "post-error", "You can't make $body empty. $body: $post"));
        exit;
    }
    return $post;
}

function makeHashPassword(string $plainPassword): string
{
    return password_hash($plainPassword, PASSWORD_DEFAULT);
}
