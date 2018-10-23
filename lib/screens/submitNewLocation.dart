import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:deepblue/models/RegisterLocationModel.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_rating/flutter_rating.dart';

class SubmitNewLocationScreen extends StatefulWidget{

  RegisterLocationModel registerModel;
   Map<String, double> pushedLocation;
  SubmitNewLocationScreen(this.registerModel,this.pushedLocation);
  @override
  _SubmitNewLocationScreen createState() => _SubmitNewLocationScreen(registerModel,pushedLocation);

}

class _SubmitNewLocationScreen extends State<SubmitNewLocationScreen>{

  RegisterLocationModel registerModel;
  Map<String, double> pushedLocation;
  _SubmitNewLocationScreen (this.registerModel, this.pushedLocation);

  Color menuBackgroundColor = Colors.blue[900];
  
  
  //_RegisterLocationScreen(this.pushedLocation);
  Future httpReturn;
  String test;
  FocusNode _focus = new FocusNode();
  

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange(){
    debugPrint("Focus: "+_focus.hasFocus.toString());
  }

  void httpRequest()async {

    var url = "http://www.nell.science/deepblue/index.php";

    http.post(url, body: {"getWashingLocations":"true",
                          "key": "0", 
                          "latitude": pushedLocation['latitude'].toString(), 
                          "longitude": pushedLocation['longitude'].toString(),
                          "hochdruckReiniger": registerModel.getHochdruckReiniger().toString(), 
                          "schaumBuerste": registerModel.getSchaumBuerste().toString(),
                          "schaumPistole": registerModel.getSchaumPistole().toString(),
                          "fliessendWasser": registerModel.getFliessendWasser().toString(),
                          "motorWaesche": registerModel.getMotorWaesche().toString(),
                          
                          })
        .then((response) {
      print("Response status: ${response.statusCode}");   
      print("Response body: ${response.body}");
      print("httpreq");

      setState((){
              test = response.body.toString();
          });

    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HochdruckReiniger ${registerModel.getHochdruckReiniger()}");
    print("schaum Buerste ${registerModel.getSchaumBuerste()}");
    print("schaum Pistole ${registerModel.getSchaumPistole()}");
    print("fliessend Wasser ${registerModel.getFliessendWasser()}");
    print("motor Waesche ${registerModel.getMotorWaesche()}");
    print("location: $pushedLocation");
    final theme = Theme.of(context);

    

    return Scaffold(
      backgroundColor: menuBackgroundColor,
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: menuBackgroundColor,
        elevation: 0.0,
      ),

      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Row(),


            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 40.0, 36.0, 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Icon(Icons.check_circle_outline,color: Colors.white,size: 30.0,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child:  Text("Waschbox bennen", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0)),
                    ),
                ],
              )
            ),



            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 10.0, 36.0, 40.0),
              child: Text("Gib deiner Waschbox die du hinzufügen möchtests einen Namen, damit andere Mitglieder diese eifnacher finden können", 
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                     ),
            
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 80.0),
              child: new Theme(
                        data: theme.copyWith(primaryColor: Colors.white,accentColor: Colors.white, hintColor: Colors.white),
                        child: new TextField(
                          focusNode: _focus,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 22.0, ),
                          decoration: new InputDecoration(
                            hintText: "Waschbox-Name",
                            hintStyle: TextStyle(color: Colors.indigo[400], fontSize: 20.0,fontWeight: FontWeight.normal),
                            border: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                color: Colors.red
                              )
                            )
                          ),
                        ),
                      ),
            ),
            

            

            /*
             new StarRating(
                            size: 40.0,
                            rating: rating,
                            color: Colors.white,
                            borderColor: Colors.white,
                            starCount: starCount,
                            onRatingChanged: (rating) => setState(
                                  () {
                                    this.rating = rating;
                                  },
                                ),
                          ),
            */
            

            
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap:(){
                        httpRequest();
                      },
                      child: new Container(
                        color: Colors.white,
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Speichern",style: TextStyle(color: menuBackgroundColor, fontSize: 16.0, fontWeight: FontWeight.bold)),
                         
                        ],
                        ),
                      )
                    ) 
                  )
                ],
              )
            )
            

          ],
        ),
      ),
    );
  }

}