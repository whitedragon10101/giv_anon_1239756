<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    use HasFactory;

    protected $primaryKey = 'user_id';
    protected $table = 'users';
    public $timestamps = false;

    public function application()
    {
        return $this->hasMany(Application::class);
    }

    public function user_role()
    {
        return $this->hasMany(User_role::class);
    }

    
}
