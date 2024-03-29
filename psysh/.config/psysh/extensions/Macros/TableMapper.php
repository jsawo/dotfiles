<?php

namespace X\Macros;

use Symfony\Component\Console\Helper\Table;
use Symfony\Component\Console\Output\BufferedOutput;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Eloquent\Model;

class TableMapper
{
    public function __invoke()
    {
        return function (?array $includeColumns = null, ?array $excludeColumns = null) {
            if ($this->count() === 0) {
                echo "[ Empty collection ] \n";
                return;
            }

            $output = new BufferedOutput();
            $table = new Table($output);
            $data = TableMapper::getData($this);

            $keys = !empty($includeColumns) ? $includeColumns : array_keys($data->get(0));
            $keys = TableMapper::filterExcludes($keys, $excludeColumns);

            $table->setHeaders($keys);

            $data->each(function($modelData) use ($table, $keys) {
                $item = [];
                foreach ($keys as $key) {
                    $field = data_get($modelData, $key);
                    if(is_array($field) || is_object($field)) $field = json_encode($field);
                    $item[$key] = $field;
                }

                $table->addRow($item);
            });

            $table->render();

            echo $output->fetch();
        };
    }

    public static function getData($collection)
    {
        if ($collection->get(0) instanceof Model) {
            return $collection->map(function($m) {
                if($m->exists) {
                    $keys = array_keys($m->attributesToArray());
                } else {
                    $keys = Schema::getColumnListing($m->getTable());
                }

                $res = [];
                foreach ($keys as $key) {
                    $res[$key] = $m->$key;
                }
                return $res;
            });
        } else {
            return $collection;
        }
    }

    public static function filterExcludes(array $keys, ?array $excludeColumns): array
    {
        if(!$excludeColumns) {
            return $keys;
        }

        return array_filter($keys, function($key) use ($excludeColumns) {
            foreach ($excludeColumns as $column) {
                if(Str::is($column, $key)) {
                    return false;
                }
            }
            return true;
        });
    }

}
