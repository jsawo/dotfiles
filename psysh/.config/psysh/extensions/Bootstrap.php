<?php

use Illuminate\Database\Query\Builder;

include_once __DIR__.'/Tinker.php';
include_once __DIR__.'/Request.php';

foreach (glob(__DIR__."/Commands/*.php") as $command) {
    include $command;
}

X\Tinker::alias("Carbon\Carbon");

Builder::macro('toRawSql', X\Tinker::rawSql());

if (!function_exists('isTinkerwell')) {
    // Try to determine if we are running Tinkerwell by looking for use of PhpScoper
    function isTinkerwell(): bool
    {
        $trace = debug_backtrace();
        foreach ($trace as $frame) {
            if (strpos($frame['function'], '_PhpScoper') !== false) {
                return true;
            }
        }
        return false;
    }
}
