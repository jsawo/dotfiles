# Laravel Tinker custom extensions

*note: this config can safely be used with Tinkerwell - the commands will *

## Commands

- `models` | `m` 

    Lists all models. Can be filtered by model name.

- `model-relations` | `mr` 

    Lists all relations on a given model.

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
