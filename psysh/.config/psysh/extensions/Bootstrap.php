<?php

use Illuminate\Database\Query\Builder;
use Illuminate\Support\Collection;

include_once __DIR__.'/Tinker.php';
include_once __DIR__.'/Request.php';

foreach (glob(__DIR__."/Commands/*.php") as $command) include_once $command;
foreach (glob(__DIR__ . "/Macros/*.php") as $macro) include_once $macro;

X\Tinker::alias("Carbon\Carbon");

Builder::macro('toRawSql', X\Tinker::rawSql());
Collection::macro('table', (new X\Macros\TableMapper)());
Collection::macro('pluckMany', (new X\Macros\PluckMany)());
Collection::macro('validate', (new X\Macros\Validate)());

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
