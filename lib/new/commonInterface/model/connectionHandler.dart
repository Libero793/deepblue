import 'package:deepblue/new/userHandlingInterface/model/userRegistrationModel.dart';
import 'package:http/http.dart' as http;

class ConnectionHandler {

    int httpRequestCounter = 0;

    void httpRequest(jsonData){

    var url = "http://www.nell.science/deepblue/index.php";

      http.post(url, body:  jsonData )
          .then((response) {
        print("register Response status: ${response.statusCode}");   
        print("Response body: ${response.body}");
        
        if(response.statusCode == 200){
          print("http Request Successfulll"+response.body.toString());
        
        }else{
          print("location registration failed, starting next Try");       
          httpRequestCounter++;
          if(httpRequestCounter>3){
            print("Max Trys exceeded, registration aborted");
          }else{
            httpRequest(jsonData);
          }
        }

      });
    }


}