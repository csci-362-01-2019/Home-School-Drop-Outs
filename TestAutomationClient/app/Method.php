<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Method extends Model
{
    protected $table = 'method_cases';

    public $primaryKey = 'method_case_id';

    public $timeStamps = true;
}
