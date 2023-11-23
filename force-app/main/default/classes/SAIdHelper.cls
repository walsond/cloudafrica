public without sharing class SAIdHelper {
    /*
     @decription : To Save the new Id and Get the list of Holidays
	 @param idNumber SA Id that is passed by the user
	 @return String of List of Holiday
	*/
    public static String getHolidays(String idNumber){
        String holidayFinal='';
        try{
            //Check the Id Number
            // Validate the ID number
            if (idNumber.length() != 13) {
               return holidayFinal;
            }
            //Get Holidays List
            holidayFinal =getHolidayList();
            
            Decimal idNo=Decimal.valueOf(idNumber);
            //Check and Upsert Data accordingly
            checkAndUpsertData(idNo);
        }catch(Exception ex){
            throw ex;
        }
        return holidayFinal;
    }
    /*
     @decription : To get list of Holidays
	 @return String of List of Holiday
	*/
    private static String getHolidayList(){
        String holidayData='';
        try{
        	holidayData=SAApiHelper.callGetAPI();
        }catch(Exception ex){
            throw ex;
        }
        return holidayData;
    }
    /*
     @decription : To Upsert the data or update the Counter
	 @param idNo SA Id that is passed by the user
	*/
    private static void checkAndUpsertData(Decimal idNo){
        try{
            //Get If Existing Number 
            SA_Citizen__c saCitizenRecord = SADatabaseHelper.getCitizenRecordById(idNo);
            //If Found Update the Counter.
            if(saCitizenRecord == null){
                saCitizenRecord=new SA_Citizen__c();
                saCitizenRecord.SA_Id_Number__c= idNo;
            }
            saCitizenRecord.Counter__c = (saCitizenRecord.Counter__c != null ? saCitizenRecord.Counter__c : 0 ) +1;
            //Update Record If Present and Insert if Not
            SADatabaseHelper.upsertCitizenRecord(saCitizenRecord);
        }catch(Exception ex){
            throw ex;
        }
    }

}