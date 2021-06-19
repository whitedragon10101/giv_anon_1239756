<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Models\Users;
use App\Http\Controllers\Application_Controller;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});


/*
Route::get('/users', function(){
    return Users::all();
});
*/

//TASK 2 - Develop an endpoint to create an application
Route::post('/application', [Application_Controller::class, 'store']);

//TASK 5 - evelop an endpoint for progressing an application
Route::put('/application/move/{id}', [Application_Controller::class, 'update']);

//BONUS TASK - endpoint to display an application with linked information
Route::get('/application/getMixedData/', [Application_Controller::class, 'getApplicationMixedData']);

