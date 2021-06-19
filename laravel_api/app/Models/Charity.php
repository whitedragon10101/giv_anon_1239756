<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Charity extends Model
{
    use HasFactory;

    protected $primaryKey = 'charity_id';
    protected $table = 'charities';
    public $timestamps = false;

    public function application()
    {
        return $this->hasMany(Application::class);
    }

    public function country()
    {
        return $this->hasOne(country::class);
    }
}
