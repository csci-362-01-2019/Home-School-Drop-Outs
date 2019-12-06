<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TestCase extends Model
{
    protected $table = 'test_cases';

    public $primaryKey = 'test_case_id';

    public $timeStamps = true;

    
    
}
