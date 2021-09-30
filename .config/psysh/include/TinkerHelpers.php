<?php

include_once __DIR__ . '/Tinker.php';
include_once __DIR__ . '/Commands.php';

if (!function_exists('isTinkerwell')) {
  // Try to determine if we are running Tinkerwell's looking for use of PhpScoper
  function isTinkerwell() : bool
  {
    $trace = debug_backtrace();
    foreach ($trace as $frame) {
      if (strpos($frame['function'], '_PhpScoper') !== false)
        return true;
    }
    return false;
  }
}
