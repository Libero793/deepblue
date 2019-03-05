import 'package:deepblue/ViewModels/nameNewLocationState.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/models/RegisterNewLocationStyleModel.dart';

class NameNewLocationView extends NameNewLocationState{
    
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("location: $widget.pushedLocation");
    final theme = Theme.of(context);

    

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("", style: TextStyle(color: Colors.black),),
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                GestureDetector(
                  onTap: _optionsDialogBox,
                  child:  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(75)),
                        color: Colors.grey[300],
                      ),
                      width: 125,
                      height: 125,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.grey[400],
                        size: 45,
                      ),
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
            
            
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap:(){
                        navigatorPushRegisterNewLocation();
                      },
                      child: new Container(
                        color: widget.coreClass.getHighlightColor(),
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Speichern",style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
                         
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

  Widget  getInputLineWidget(theme){
    return  Padding(
              padding: EdgeInsets.fromLTRB(35, 10, 35, 30),
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
                      child:Icon(widget.registerLocationClass.getIcon(),color: locationNameIconColor,),
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
    
    String entryOptionName = boxStyleEntrys[position];

    return 
    Padding(
      padding:EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Container(
        decoration:  new BoxDecoration(
          border: new Border.all(color: boxStyleMap["$entryOptionName"].textColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: boxStyleMap["$entryOptionName"].backgroundColor,
        ),
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),
          child:    Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(boxStyleMap["$entryOptionName"].option, style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16.0, color: boxStyleMap["$entryOptionName"].textColor),)    
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical:0.0),
                child: Theme(
                  data: ThemeData(
                    disabledColor: Colors.grey,
                    unselectedWidgetColor: Colors.grey,
                  ),
                  child: Checkbox(                                          
                    value: boxStyleMap["$entryOptionName"].state,
                    onChanged: (bool e) => toggleSwitch(e,boxStyleMap["$entryOptionName"]),
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

  Future<void> _optionsDialogBox() {
  return showDialog(context: context,
    builder: (BuildContext context) {
        return AlertDialog(
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                GestureDetector(
                  child: new Text('Take a picture'),
                  onTap: (){
                    getImage("camera");
                  }
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: new Text('Select from gallery'),
                  onTap: (){
                    getImage("gallery");
                  }
                ),
              ],
            ),
          ),
        );
      });
}

}