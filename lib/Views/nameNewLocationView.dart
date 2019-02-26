import 'package:deepblue/ViewModels/nameNewLocationState.dart';
import 'package:flutter/material.dart';

class NameNewLocationView extends NameNewLocationState{
    
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("location: $widget.pushedLocation");
    final theme = Theme.of(context);

    

    return Scaffold(
      backgroundColor: widget.coreClass.getHighlightColor(),
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: widget.coreClass.getHighlightColor(),
        elevation: 0.0,
      ),

      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 40.0, 36.0, 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Icon(Icons.check_circle_outline,color: Colors.white,size: 30.0,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child:  Text("Location bennen", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26.0)),
                    ),
                ],
              )
            ),



            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 10.0, 36.0, 40.0),
              child: Text("Gib deiner Location die du hinzufügen möchtests einen Namen, damit andere Mitglieder diese einfacher finden können", 
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                     ),
            
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 80.0),
              child: new Theme(
                        data: theme.copyWith(primaryColor: Colors.white,accentColor: Colors.white, hintColor: Colors.white),
                        child: new TextField(
                          focusNode: focus,
                          controller: textFieldController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 22.0, ),
                          decoration: new InputDecoration(
                            hintText: "Location",
                            hintStyle: TextStyle(color: Colors.blue[100], fontSize: 20.0,fontWeight: FontWeight.normal),
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
                        navigatorPushRegisterNewLocation();
                      },
                      child: new Container(
                        color: Colors.white,
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Weiter",style: TextStyle(color: widget.coreClass.getHighlightColor(), fontSize: 16.0, fontWeight: FontWeight.bold)),
                         
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