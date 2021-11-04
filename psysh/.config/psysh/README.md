# Laravel Tinker custom extensions

*note: this config can safely be used with Tinkerwell - the commands will*

## Commands

- `models` | `m`

    Lists all models. Can be filtered by model name.

- `model-relations` | `mr`

    Lists all relations on a given model (relies on method return types).

- `controllers` | `c`

    Lists all controllers. Can be filtered by controller name.

- `routes` | `r`

    Lists all routes. Can be filtered by route url.

- `artisan` | `a`

    Lists all artisan commands. If command name is provided, will run given command. Just a simple proxy for `php artisan`

## Requests

You can execute custom http requests against your application with `X\Request` class.

    (new X\Request)->get('/')

This class actually extends Laravel's `TestCase` so you can use it the same way that you would inside your tests. This allows you to e.g. interact with authentication:

    (new X\Request)
        ->actingAs(User::first())
        ->get('/dashboard')

and make assertions:

    (new X\Request)->get('/users')
        ->assertOk()

to inspect the response headers, you can use:

    (new X\Request)->get('/users')
        ->baseResponse->headers->all()

or

    (new X\Request)->get('/users')
        ->dumpHeaders()

to inspect the response body:

    (new X\Request)->get('/users')
        ->baseResponse->content()

or

    (new X\Request)->get('/users')
        ->dump()


## Macros

On `Illuminate\Support\Collection`:

- `table()` dumps the given collection of models or arrays to a table

    ```
    >>> Rate::all()->table()
    +----+--------+---------------------+---------------------+---------------------+---------------------+
    | id | amount | date_start          | date_end            | created_at          | updated_at          |
    +----+--------+---------------------+---------------------+---------------------+---------------------+
    | 1  | 42249  | 2015-01-01 00:00:00 | 2015-12-31 00:00:00 |                     |                     |
    | 2  | 41749  | 2016-01-01 00:00:00 | 2016-12-31 00:00:00 |                     |                     |
    | 3  | 41749  | 2017-01-01 00:00:00 | 2017-12-31 00:00:00 | 2017-03-23 10:43:21 | 2017-03-23 10:43:21 |
    | 4  | 43117  | 2018-01-01 00:00:00 | 2018-12-31 00:00:00 | 2018-01-03 08:29:23 | 2018-09-19 08:53:38 |
    | 5  | 43117  | 2019-01-01 00:00:00 | 2019-12-31 00:00:00 | 2019-01-07 07:47:25 | 2019-01-07 07:47:25 |
    +----+--------+---------------------+---------------------+---------------------+---------------------+
    ```

    This macro also allows you to filter columns you want to return:

    ```
    >>> Rate::all()->table([],['*_at'])
    +----+--------+---------------------+---------------------+
    | id | amount | date_start          | date_end            |
    +----+--------+---------------------+---------------------+
    | 1  | 42249  | 2015-01-01 00:00:00 | 2015-12-31 00:00:00 |
    | 2  | 41749  | 2016-01-01 00:00:00 | 2016-12-31 00:00:00 |
    | 3  | 41749  | 2017-01-01 00:00:00 | 2017-12-31 00:00:00 |
    | 4  | 43117  | 2018-01-01 00:00:00 | 2018-12-31 00:00:00 |
    | 5  | 43117  | 2019-01-01 00:00:00 | 2019-12-31 00:00:00 |
    +----+--------+---------------------+---------------------+
    ```

    Or Columns you want to hide (with wildcards):

    ```
    >>> Rate::all()->table([],['date*', '*_at'])
    +----+--------+
    | id | amount |
    +----+--------+
    | 1  | 42249  |
    | 2  | 41749  |
    | 3  | 41749  |
    | 4  | 43117  |
    | 5  | 43117  |
    +----+--------+
    ```
- `pluckMany()` like pluck but can select more than one column (provided by Spatie's [laravel-collection-macros](https://github.com/spatie/laravel-collection-macros))

    ```
    >>> collect([
          ['a' => 1, 'b' => 10, 'c' => 100],
          ['a' => 2, 'b' => 20, 'c' => 200],
        ])->pluckMany(['a', 'b']);

    => collect([
         ['a' => 1, 'b' => 10],
         ['a' => 2, 'b' => 20],
       ]);
    ```

- `validate()` returns `true` if the given `$callback` returns true for every item (provided by Spatie's [laravel-collection-macros](https://github.com/spatie/laravel-collection-macros))

    ```
    >>> User::all()->validate(fn($u) => $u->id > 0)
    => true
    >>> User::all()->validate(fn($u) => $u->id > 2)
    => false
    ```

    If `$callback` is a string or an array, regard it as a validation rule.

    ```
    >>> collect(['aaa@aaa.com'])->validate('email')
    => true
    >>> collect(['aaa@aaa.com', 'aaaa'])->validate('email')
    => false
    ```

On `Illuminate\Database\Eloquent\Builder`:

- `toRawSql()`:

    ```
    >>> DB::table("users")->where("id", 101)->toRawSql()
    => "select * from `users` where `id` = 101"
    ```

## Casters

Custom casters are provided for:

- `Illuminate\Database\Eloquent\Builder` and `Illuminate\Database\Query\Builder`

    ```
    >>> User::where('id', 101)
    => Illuminate\Database\Eloquent\Builder {#3608
         +sql: "select * from `users` where `id` = 101",
         +query: "select * from `users` where `id` = ?",
         +bindings: [
           0 => 101,
         ],
       }
    ```

## Aliases

Provides aliases for:

- `Carbon\Carbon` - so you can refer to `Carbon` instead
