import React, { Component } from 'react';
import axios from "axios";


class Applications extends Component 
{
    state = {  
        user_id_loggedin: 4,
        error: null,
        isLoaded: false,
        application_data: []

    }

    componentDidMount() 
    {
        this.getNewData();
    }

    async getNewData(){
        const response =
          await axios.get("api/application/getMixedData/")
          this.setState({
            isLoaded: true,
            application_data: response.data
          });
    }

    moveApplication(application_id,stage,direction)
    {
        stage = direction === 'forward' ? stage+1 : stage-1;
       
        const user_id = this.state.user_id_loggedin;

        console.log('user_id = '+ user_id+' stage = '+stage+' application id = '+ application_id)

        const packets = {
            user_id:  user_id,
            stage: stage,
        };
        axios.put('api/application/move/'+application_id, packets)
            .then(
                //response => alert(JSON.stringify(response.data))
                this.getNewData()
                )
            .catch(error => {
                console.log("ERROR:: ",error.response.data);
                alert("ERROR:: "+error.response.data);
                });

    }

    changeLoggedInUserId(event)
    {
        this.setState({user_id_loggedin: event.target.value });        
    }

    render() { 
        const { error, isLoaded, application_data, user_id_loggedin } = this.state;
        if (error) {
          return <div>Error: {error.message}</div>;
        } else if (!isLoaded) {
          return <div>Loading...</div>;
        } else {

          return (
            <React.Fragment>
            
            <div id="user_input_container">
            <label htmlFor="user_id_input">Simulating this User ID Logged In</label>
            <input id="user_id_input" type='text' value={user_id_loggedin} onChange={(e)=>this.changeLoggedInUserId(e)}/>
            </div>
           
            <div className="data_table">

                <div>Application ID</div><div >User Name</div><div>Charity Name</div><div>Charity Country</div><div>Application Stage</div><div>Date created</div><div>Move</div>
                {application_data.map(application => (
                <React.Fragment key={application.application_id}>
                    <div>{application.application_id}  </div>
                    <div>{application.name}  </div>
                    <div>{application.charity_name} </div>
                    <div>{application.country_name} </div>
                    <div> {application.stage_name} </div>
                    <div> {application.created_at} </div>
                    <div> <button onClick={()=>this.moveApplication(application.application_id,application.stage,'back')}>Back</button> &nbsp;<button onClick={()=>this.moveApplication(application.application_id,application.stage,'forward')}>Forward</button> </div>
                </React.Fragment>
                ))}

            </div>     
            </React.Fragment>

          );

        }
      }
}
 
export default Applications; 