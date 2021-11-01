<?php

include_once __DIR__.'/extensions/Bootstrap.php';

$commands = isTinkerwell() ? [] : [
    new X\Commands\Routes(),
    new X\Commands\Models(),
    new X\Commands\Controllers(),
    new X\Commands\Artisan(),
    new X\Commands\ModelRelations(),
];

return [
    'casters' => [
        'Illuminate\Database\Eloquent\Builder' => 'X\Tinker::castQuery',
        'Illuminate\Database\Query\Builder' => 'X\Tinker::castQuery',
    ],

    'commands' => $commands,

    'defaultIncludes' => [],

    'forceArrayIndexes' => true,
    'historySize' => 500,
    'eraseDuplicates' => true,

    'matchers' => [
        // new \Psy\TabCompletion\Matcher\MongoClientMatcher,
        // new \Psy\TabCompletion\Matcher\MongoDatabaseMatcher,
    ],

    // Specify a custom prompt.
    // 'prompt' => '>>>',

    // 'startupMessage' => '<info>Using local config file (~/.config/psysh/config.php)</info>',
    'useBracketedPaste' => true,
    'warnOnMultipleConfigs' => true,
];
