<?php

namespace X;

use Illuminate\Support\Facades\File;

class Tinker
{
  public static function rawSql() {
    return function () {
      $bindings = array_map(
        fn ($bin) => is_int($bin) || is_float($bin) ? $bin : "'{$bin}'",
        $this->getBindings()
      );

      return vsprintf(str_replace('?', "%s", $this->toSql()), $bindings);
    };
  }

  public static function alias($class, $alias = null) : void
  {
    if (!class_exists($alias = $alias ?: class_basename($class)) && class_exists($class)) {
      class_alias($class, $alias);
    }
  }

  static function castQuery($query): array
  {
    if ($query instanceof \Illuminate\Database\Eloquent\Builder)
      $query = $query->getQuery();

    return [
      'sql' => $query->toRawSql(),
      'query' => $query->toSql(),
      'bindings' => $query->getBindings(),
    ];
  }

  public static function getSubclasses($superclass)
  {
    $composer = json_decode(file_get_contents(base_path('composer.json')), true);
    $models = [];
    foreach ((array) data_get($composer, 'autoload.psr-4') as $namespace => $path) {
      $models = array_merge(
        collect(File::allFiles(base_path($path)))
          ->map(function ($item) use ($namespace) {
            $path = $item->getRelativePathName();
            return sprintf(
              '\%s%s',
              $namespace,
              strtr(substr($path, 0, strrpos($path, '.')), '/', '\\')
            );
          })
          ->filter(function ($class) use ($superclass) {
            $valid = false;
            if (class_exists($class)) {
              $reflection = new \ReflectionClass($class);
              $valid = $reflection->isSubclassOf($superclass)
                && !$reflection->isAbstract();
            }
            return $valid;
          })
          ->values()
          ->toArray(),
        $models
      );
    }
    return $models;
  }
}

class Request extends \Tests\TestCase
{
  function __construct()
  {
    $this->setUp();
  }

  function response()
  {
    return $this->response;
  }

  function __call($method, $params)
  {
    return call_user_func_array([$this, $method], $params);
  }
}