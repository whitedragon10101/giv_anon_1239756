**README**



**Tasks**



**1) Develop and application model**

The tables for this can be found in the Gf_db_file.sql (installation instructions below). 

I used the MVC framawork Laravel for the php.  The php laravel model files are in :

```
Laravel_api\app\models\
```

I also added an additional model called Application_stages.  This allows the numerical stage property from Applications to be matched with a string describing what that stage actually is.



**2) Develop an endpoint to create an application**

The endpoint can be found in 

```
Laravel_api\routes\api.php
```

The controller for the endpoint can be found in

```
Laravel_api\app\Http\Controllers\Application_Controller.php
```



**3) Write a method for validating if a user can take certain actions**

This method can be found in the application controller

```
Laravel_api\app\Http\Controllers\Application_Controller.php
```

The method is called    

```
 public function getPermission($user_id_in, $permission_required)
```

It takes in the user_id and a string describing what permission you need verification for.  These are the acceptable strings

```
create_application , move_application , see_reports , approve_charity
```

It returns true if the user has permission and false if they do not.

**4) Write a method for validating that an application can be moved**

This method can be found in the application controller

```
Laravel_api\app\Http\Controllers\Application_Controller.php
```

The method is called    

```
public function canItMove($application,$stage)
```

It checks all the conditions required in the task. It also checks to make sure that there is actually a stage higher or lower than the current stage.  e.g If at stage 0 it will not allow you to go to -1.

**5) Develop an endpoint for progressing an application**

The endpoint can be found in 

```
Laravel_api\routes\api.php
```

The controller for the endpoint can be found in

```
Laravel_api\app\Http\Controllers\Application_Controller.php
```

The method in the controller used is 

```
public function update(Request $request, $id)
```



**6 BONUS Task ) Use JavaScript (Vanilla, React or jQuery) to access one of your endpoints.**

The frontend was developed in React. It can be found in the frontend_react folder.

The frontend displays a list of the applications along with their associated charities and users.  To do this I created a new endpoint in the Laravel api file called 

```
Route::get('/application/getMixedData/', [Application_Controller::class, 'getApplicationMixedData']);
```

The controller for the endpoint can be found in

```
Laravel_api\app\Http\Controllers\Application_Controller.php
```

The method is 

```
public function getApplicationMixedData()
```

As there is no authentication or login I have simulated the logged in user just for demonstration purposes with a text field that you can enter a user_id.  By default the number will be 4 which is a user which has permission to move an application. If you change this to 2 you can see the behaviour for a user which does not have the correct permission to move and application.

The last column in the table contains two buttons backward and forward.  These buttons trigger the endpoint from task 5 along with all associated validation.  When an error occurs the users is alerted with an alert message describing what is wrong in plain english. 



--------------------



**Running the Server**

**1)**

Setup a local mysql database by importing the file Gf_db_file.sql

The file contains two new tables 

applications : 

This contains the data for the new applications 

application_stages : 

This allows the application stages to be reported to the front end as plain text instead of numbers

**2)**

The laravel project has an env file located here

```
 Laravel_api\.env
```

The following values need to be edited.  If your hosting port and ip are the same likely only the password will require changing.

```
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=gf_interview_task
DB_USERNAME=root
DB_PASSWORD=********
```

**3)**

To start the server use a terminal to navigate to the laravel_api directory and type 

```
php artisan serve 
```

The server should now be live.

Note :

If laravel 8 is not installed instructions for installation can be found here:

https://laravel.com/docs/8.x/installation



**Running the React Front end** 

**1)** 

Then to run the front end React app open a new terminal and cd into front_end_react and type

```
npm install //just on the first time to install dependencies
npm start
```

This use node to start a server and serve the react app on  http://localhost:3000

This usally opens a browser to use the app at this address automatically.



Note :

If npm (node package manager) is not installed, the node installer can be found here

https://nodejs.org/en/download/







