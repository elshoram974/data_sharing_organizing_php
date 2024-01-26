<?php
function getDifferenceTimeFromNow(DateTime $dateTime): int
{
    return time() - strtotime($dateTime->format('Y-m-d H:i:s'));
}
