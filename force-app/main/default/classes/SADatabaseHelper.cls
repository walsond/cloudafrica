public without sharing class SADatabaseHelper {
    /**
     * @description : To get the Citizen Record Based on the SA Id Number
     * @param idNo IdNumber
     * @return Citizen Record based on the Id passed 
	*/
    public static SA_Citizen__c getCitizenRecordById(Decimal idNo){
        SA_Citizen__c saCitizenRecord = null;
        try{
            List<SA_Citizen__c> lstSaRecord=[Select Id,Name,SA_Id_Number__c,Date_Of_Birth__c
                                             ,Gender__c,Is_Citizen__c,Counter__c from SA_Citizen__c 
                                             where SA_Id_Number__c =:idNo  Limit 1];
            if(lstSaRecord.size() > 0){
                saCitizenRecord=lstSaRecord[0];
            }
        }catch(Exception ex){
            throw ex;
        }
        return saCitizenRecord;
    }
    /**
     * @description : To upsert the record
     * @param saCitizenRecord IdNumber
	*/
    public static void upsertCitizenRecord(SA_Citizen__c saCitizenRecord){
        try{
            //Update Record If Present and Insert if Not
            if(saCitizenRecord !=null){
                upsert saCitizenRecord;
            }            
        }catch(Exception ex){
            throw ex;
        }
    }
}