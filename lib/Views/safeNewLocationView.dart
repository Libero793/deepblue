import 'package:deepblue/ViewModels/safeNewLocationState.dart';
import 'package:flutter/material.dart';

class SafeNewLocationView extends SafeNewLocationState{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget.registerLocationClass.toString());
    print("uid: $finudid");
    return Scaffold(
      backgroundColor: widget.coreClass.getColorSheme(widget.registerLocationClass.getLocationType()),
      appBar: AppBar(
        leading: Container(),
        title: Text(""),
        centerTitle: true,
        backgroundColor: widget.coreClass.getColorSheme(widget.registerLocationClass.getLocationType()),
        elevation: 0.0,
      ),

      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

           getStatusWidget(),
           
            

             new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap:(){

                        navigatorPushToHomeScreen();

                      },
                      child: new Container(
                        color: Colors.white,
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Schliessen",style: TextStyle(color: widget.coreClass.getColorSheme(widget.registerLocationClass.getLocationType()), fontSize: 16.0, fontWeight: FontWeight.bold)),
                        ],
                        ),
                      )
                    ) 
                  )
                ],
              )
           

           
          ],
        ),
      ),
    );
  }

  Widget getStatusWidget(){
    if(showLoadingAnimation){
      return Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[

                 Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                     SizedBox(
                    child: new CircularProgressIndicator(backgroundColor: Colors.white,valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
                    height: 75.0,
                    width: 75.0
                  ),    

                    ],
                  )
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("übertrage Daten ...", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0,), textAlign: TextAlign.center,),
                    ],
                  )
                ),
                
                
               ],
             ),
           );

    }else{
      return showStatusWidget();
    }
  }

  Widget showStatusWidget(){
    if(locationRegistrationStatus){
      return Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.beenhere, color: Colors.white,size: 150.0,),
                    ],
                  )
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Gespeichert!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0,), textAlign: TextAlign.center,),
                    ],
                  )
                ),

               ],
             ),
           );
    }else{
      return Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.mood_bad, color: Colors.white,size: 150.0,),
                    ],
                  )
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Fehler, übertragung gescheitert", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0,), textAlign: TextAlign.center,),
                    ],
                  )
                ),

               ],
             ),
           );
    }
  }

}