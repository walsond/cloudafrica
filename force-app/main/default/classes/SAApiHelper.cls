public without sharing class SAApiHelper {
    /**
     * @description : To get list of  Holidays
     * @return json of string of Holidays
	*/
    public static String callGetAPI() {
        String responseBody='';
        try{
            // Create a new http object to send the request
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            // Set the endpoint URL
            string endpointUrl='/api/v2/holidays?api_key=24c5e86734eb44dc4a962826324a5546e74dc42f&country=ZA&year=2023';
            request.setEndpoint('callout:Holiday_API'+endpointUrl);
            // Set the HTTP method to GET
            request.setMethod('GET');
            // Set the request header
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            // Send the request and get the response
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if (response.getStatusCode() == 200) {
                responseBody=response.getBody();
            }
        }catch(Exception ex){
          throw ex; 
        }
        return responseBody;
    }
}