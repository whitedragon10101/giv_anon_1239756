<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Application extends Model
{
    use HasFactory;

    protected $primaryKey = 'application_id';
    protected $table = 'applications';

    protected $fillable = [
        'user_id',
        'charity_id',
        'stage'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function charity()
    {
        return $this->hasOne(Charitie::class);
    }
}
