<?php

namespace X;

use Tests\TestCase;

class Request extends TestCase
{
    function __construct()
    {
        $this->setUp();
    }

    function __call($method, $params)
    {
        return call_user_func_array([$this, $method], $params);
    }
}
