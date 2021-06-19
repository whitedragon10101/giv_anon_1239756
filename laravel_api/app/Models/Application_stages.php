<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Application_stages extends Model
{
    use HasFactory;

    protected $primaryKey = 'application_stages_id';
    protected $table = 'application_stages';
}
