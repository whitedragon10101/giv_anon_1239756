<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    use HasFactory;

    protected $primaryKey = 'country_id';
    protected $table = 'countries';
    public $timestamps = false;

    public function charity()
    {
        return $this->hasMany(Charity::class);
    }

}