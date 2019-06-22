import 'package:flutter/material.dart';

class DesignPatterns{

  Widget customOutlineButton({String text}){
    return OutlineButton(

      borderSide: BorderSide(
        color: Colors.white,
        width: 1.5,
      ),  
      
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0, 10.0),
      textColor: Colors.white,
      highlightColor: Colors.transparent,
      highlightedBorderColor: Colors.white,
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0)),  
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                                            /*
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                              child: Icon(Icons.location_on,color: Colors.white,),
                                              ),*/                               
             Text(text, style: TextStyle(fontSize: 17.0, color: Colors.white),),
          ]                                                 
        ),      
      onPressed: () {},
    );
  }

  Widget seperator(){
    return Expanded(
      child: Container(
        color: Colors.white,
        height: 1.0,
      ),
    );
  }

  Widget  inputLineWidget({ThemeData theme, TextEditingController controller, FocusNode focusNode,String hintText, IconData icon}){
    return   Container(
                
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.white),
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child:Icon(icon,color: Colors.white,size: 30,),
                    ),
                    

                    Expanded(
                      child:  Theme(
                          data: theme.copyWith(
                            primaryColor: Colors.transparent,
                            accentColor: Colors.orange, 
                            hintColor: Colors.transparent),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: new TextField(
                              focusNode: focusNode,
                              controller: controller,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.w300),
                              decoration: new InputDecoration(
                                hintText: hintText,
                                hintStyle: TextStyle(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.w300)
                              ),
                            ),
                          )
                          
                          
                        ),
                    )
                          
                  ],
                ),
            
            );
  }



}