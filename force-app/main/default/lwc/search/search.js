import { LightningElement, track  } from 'lwc';
import validateAndSendId from '@salesforce/apex/SAIdController.validateAndSendId';
export default class Search extends LightningElement {

    @track idNumber;
    @track disableSearch=true;
    @track lstholiday=[];
    @track columns;
    @track tablevisible=false;
    

    handleIdChange(event) {
        debugger;
        this.idNumber = event.target.value;
        const saIdRegex =/(((\d{2}((0[13578]|1[02])(0[1-9]|[12]\d|3[01])|(0[13456789]|1[012])(0[1-9]|[12]\d|30)|02(0[1-9]|1\d|2[0-8])))|([02468][048]|[13579][26])0229))(( |-)(\d{4})( |-)(\d{3})|(\d{7}))/;
        let currentValue=this.idNumber;
        // Test the regex
        let isValid = currentValue.match(saIdRegex);
        if (isValid) {
            this.disableSearch=false;
            console.log('The South African ID number is valid.');
        } else {
            this.disableSearch=true;
            console.log('The South African ID number is not valid.');
        }
    }

    handleClick() {
        
        validateAndSendId({ idNumber: this.idNumber })
            .then(result => {
                // handle successful response
               this.handleSuccess(result);
            })
            .catch(error => {
                // handle error
                
                console.log('Error Details ===>'+JSON.stringify(error));
                console.log('Error In Calling the API');
            });
    }


    handleSuccess(finalResult){
        console.log('Result Data ===>'+finalResult);
        console.log('Result Type of ===>'+typeof finalResult);
        let finalParseResult=JSON.parse(finalResult);
        let lstholidays=finalParseResult.response.holidays;
        

        this.columns = [
            { label: 'Name', fieldName: 'name' },
            { label: 'Date', fieldName: 'hldate', type: 'date' },
            { label: 'Holiday Type', fieldName: 'type'}
        ];

        for(var singleHoliday of lstholidays){
            let currentValue={
                name: singleHoliday.name,
                hldate : singleHoliday.date.iso,
                type : singleHoliday.primary_type
            };
            this.lstholiday.push(currentValue);
        }

        console.log('Holiday List ===>'+this.lstholiday);
        console.log('Holiday One  ===>'+this.lstholiday[0].name);

        if(this.lstholiday.length > 0){
            this.tablevisible=true;
        }

    }
    
}