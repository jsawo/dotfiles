<?php

include_once __DIR__ . '/include/TinkerHelpers.php';

X\Tinker::alias("Carbon\Carbon");

\Illuminate\Database\Query\Builder::macro('toRawSql', X\Tinker::rawSql());

$commands = isTinkerwell() ? [] : [
  new X\RoutesCommand(),
  new X\ModelsCommand(),
  new X\ControllersCommand(),
  new X\ArtisanCommand(),
  new X\ModelRelationsCommand(),
];

return [
  'casters' => [
    'Illuminate\Database\Eloquent\Builder' => 'X\Tinker::castQuery',
    'Illuminate\Database\Query\Builder' => 'X\Tinker::castQuery',
  ],

  'commands' => $commands,

  'defaultIncludes' => [
    __DIR__ . '/include/Tinker.php',
    __DIR__ . '/include/TinkerHelpers.php',
  ],

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
