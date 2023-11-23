global without sharing class SAIdController {
    /*
     @decription : To Save the new Id and Get the list of Holidays
	 @param idNumber SA Id that is passed by the user
	 @return String of List of Holiday
	*/
	@AuraEnabled
    public static String validateAndSendId(String idNumber) {
        String finalresult='';
        try{
            finalresult=SAIdHelper.getHolidays(idNumber);
        }catch(Exception ex){
            System.Debug('Exception in validateAndSendId Function'+ex.getStackTraceString());
        }
        return finalresult;
    }
}