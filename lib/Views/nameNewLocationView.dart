import 'package:deepblue/ViewModels/nameNewLocationState.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/models/RegisterLocationStyleModel.dart';

class NameNewLocationView extends NameNewLocationState{
    
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("location: $widget.pushedLocation");
    final theme = Theme.of(context);

    String addLocationTypeName;
    String addLocationTypeShortName;

    if(widget.registerLocationClass.getLocationType() == "washbox"){
      addLocationTypeName = "deiner Waschbox";
      addLocationTypeShortName = "Waschbox";
    }else if(widget.registerLocationClass.getLocationType() == "shooting"){
      addLocationTypeName = "deinem Foto Spot";
      addLocationTypeShortName = "Foto Spot";
    }else if(widget.registerLocationClass.getLocationType() == "event"){
      addLocationTypeName = "deinem Event";
      addLocationTypeShortName = "Event";
    }

    

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Location hinzufügen", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: Colors.black, //change your color here
        ),
      ),

      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(75)),
                      color: Colors.grey[300],
                    ),
                    width: 125,
                    height: 125,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[400],
                      size: 45,
                    ),
                  ),
                )

              ],
            ),   
            
            getInputLineWidget(theme),
            
            

            new Expanded(
              child:  ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: boxStyleMap.length,
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, position) {
                          return getCheckboxWidget(position);
                        },
                      ),
            ),
            

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

  Widget  getInputLineWidget(theme){
    return  Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
              child:  Container(
                
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: locationNameUnderlineColor),
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child:Icon(Icons.my_location,color: locationNameIconColor,),
                    ),
                    

                    Expanded(
                      child:  Theme(
                          data: theme.copyWith(
                            primaryColor: Colors.transparent,
                            accentColor: Colors.orange, 
                            hintColor: Colors.transparent),
                          child: new TextField(
                            focusNode: focusTextWidget,
                            controller: textFieldController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 20.0, ),
                            decoration: new InputDecoration(
                              hintText: "Location Name",
                              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 20.0,fontWeight: FontWeight.normal)
                            ),
                          ),
                        ),
                    )
                          
                  ],
                ),
              ),
            );
  }

  Widget getCheckboxWidget(position){

    return 
    Padding(
      padding:EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Container(
        decoration:  new BoxDecoration(
          border: new Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: boxStyleMap[position].backgroundColor,
        ),
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
          child:    Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(boxStyleMap[position].option, style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16.0, color: boxStyleMap[position].textColor),)    
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical:0.0),
                child: Theme(
                  data: ThemeData(
                    disabledColor: Colors.grey,
                    unselectedWidgetColor: Colors.grey,
                  ),
                  child: Checkbox(                                          
                    value: boxStyleMap[position].state,
                    onChanged: (bool e) => toggleSwitch(e),
                    activeColor: widget.coreClass.getHighlightColor(),
                  ),
                ),                                            
              ),

            ],
          )    
        ),
      ),  
    );
  }

}