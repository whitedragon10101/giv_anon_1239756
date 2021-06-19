<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Application;
use App\Models\Application_stages;
use App\Models\User;
use App\Models\User_role;
use App\Models\Charity;

use Illuminate\Support\Facades\DB;
use \Illuminate\Http\Response;

class Application_Controller extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    /*
    public function index()
    {
        //
    }
    */


    //BONUS TASK - endpoint to display an application with linked information
    public function getApplicationMixedData()
    {
        error_log("Getting application mixed data");


        $application_data = DB::table('applications')
            ->select('applications.application_id','users.name','charities.charity_name','countries.country_name','applications.stage','application_stages.stage_name','applications.created_at')
            ->leftJoin('users', 'applications.user_id', '=', 'users.user_id')
            ->leftJoin('charities', 'applications.charity_id', '=', 'charities.charity_id')
            ->leftJoin('countries', 'charities.country_id', '=', 'countries.country_id')
            ->leftJoin('application_stages', 'applications.stage', '=', 'application_stages.stage_number')

            ->get();


        return response($application_data);
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

    //TASK 2 - Develop an endpoint to create an application
    public function store(Request $request)
    {

        $request->validate([
            'user_id' => 'required',
            'charity_id' => 'required'

        ]);
        
        $user_id = $request->input('user_id');
        $charity_id = $request->input('charity_id');
        //if user does not have permission return with error
        if(! ($this->getPermission($user_id,'create_application')))
        {
            return response("user unauthorised to create application",403);
        }

        $charity = Charity::where('charity_id',$request->input('charity_id'))->get()-> first();
        if(!$charity)
        {
            return response("error-charity does not exist",404);
        }

        //redundant now as noth charity is approved and application state match at 0 and 1
        // but in the future its possible the numbers for the application stages will not be 0 and 1
        $application_stage = $charity->is_approved == 1 ? 1 : 0;

        return Application::create([
            'user_id' => $user_id,
            'charity_id' => $charity_id,
            'stage' => $application_stage
        ]);
    
    }

    //TASK 3 - method for validating if a user can take certain actions
    public function getPermission($user_id_in, $permission_required)
    {   
        $acceptable_roles= [];
        if($permission_required == 'create_application')
        {
            $acceptable_roles[] = 'employee';
        }
        else if($permission_required == 'move_application')
        {
            $acceptable_roles[] = 'admin';
            $acceptable_roles[] = 'admin_applications';
        }
        else if($permission_required == 'see_reports')
        {
            $acceptable_roles[] = 'admin';
            $acceptable_roles[] = 'admin_reports';
        }
        else if($permission_required == 'approve_charity')
        {
            $acceptable_roles[] = 'admin';
        }

        $user_roles = User_role::where('user_id', $user_id_in)->get();

        foreach($user_roles as $role)
        {
            //if the user has an instance of the role required delete it from permissions_required
            if (($key = array_search($role->role , $acceptable_roles)) !== false) {
                unset($acceptable_roles[$key]);
            }
        }



        //if all the permissions were found the permission_required array will now be empty
        //returns true for empty and false for not empty
        return empty($acceptable_roles);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */

    //update to move an application forward or back
    public function update(Request $request, $id)
    {

        $request->validate([
            'user_id' => 'required',
            'stage' => 'required'
        ]);
    


        $user_id = $request->input('user_id');
        $stage = $request->input('stage');
        $application_id = $id;

        error_log("update : application_id = ".$application_id."user_id = ".$user_id." stage=".$stage);


        //if user does not have permission return with error
        if(! ($this->getPermission($user_id,'move_application')))
        {
            return response("user unauthorised to move application",403);
        }

        $application = Application::find($id);
        if(!$application)
        {
            return response("no application found with this id",404);
        }

        if(!$this->canItMove($application, $stage))
        {
            return response("the application can't be moved",400);
        }
       
        $application->update([
                'stage' => $stage
        ]);
        return $application;
       
    }

    //TASK 4 - method for validating that an application can be moved
    public function canItMove($application,$stage)
    {
        if($stage<0)
        {
            echo "application stage cannot go farther back - ";
            return false;
        }
        if($stage>2)
        {
            echo "application stage cannot go farther forward - ";
            return false;
        }

        $charity_id = $application->charity_id;
        $charity = Charity::where('charity_id', $charity_id)->first();

        //if application is moving forward check forward conditions
        if($stage > $application->stage)
        {
            $datetimeVal = $application->created_at;

            if(!$this->isPast($datetimeVal))
            {
                echo "application date is not in the past - ";
                return false;
            }     

            if(!$this->charityInUK($charity))
            {
                echo "charity is outside uk - ";
                return false;
            }
            if($charity->is_approved == 0)
            {
                echo "charity not approved - ";
                return false;
            }
        }
        else //else check backward conditions
        {
            if(!$this->charityInUK($charity))
            {
                echo "charity is outside uk - ";
                return false;
            }
        }
        return true;
    }

    //check if charity is in the UK
    function charityInUK($charity)
    {
        if($charity->country_id == 223)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    //is this datetime in the past
    function isPast($time)
    {
        return (strtotime($time) < time());
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
