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
    var obscureText = false;
    if(hintText == "Password"){
      obscureText =true;
    }
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
                      padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
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
                              obscureText: obscureText,
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

  Widget inputBoxWidget({String inputText, bool obscureText,TextEditingController controller}){
    return TextFormField(
              decoration: new InputDecoration(
                labelStyle: new TextStyle(color: Colors.white),
                labelText: inputText,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(4.0),
                  borderSide: new BorderSide(
                  ),
                ),
              
              ),
              
              validator: (val) {
                if(val.length==0) {
                  return "Email cannot be empty";
                }else{
                  return null;
                }
              },

              controller: controller,
              
              keyboardType: TextInputType.emailAddress,
              obscureText: obscureText,
              style: new TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
                fontSize: 18,
              ),
            );
  }

  Widget bottomButtonWidget(Function callback){
    return  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap:(){
                        callback();
                      },
                      child: new Container(
                        color: Colors.white,
                        height: 60.0,
                        child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Registrieren",style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                         
                        ],
                        ),
                      )
                    ) 
                  )
                ],
              );
  }



}