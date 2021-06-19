<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class User_role extends Model
{
    use HasFactory;

    protected $primaryKey = 'user_role_id';
    protected $table = 'user_roles';
    public $timestamps = false;

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
