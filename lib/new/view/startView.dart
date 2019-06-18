import 'package:deepblue/new/controller/startController.dart';
import 'package:deepblue/new/view/appScreen.dart';
import 'package:deepblue/new/view/patterns.dart/designPatterns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartScreenView extends StartScreenController {

  DesignPatterns designPatterns = new DesignPatterns();

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
       body: new Center(
              child: Stack(                
                children: <Widget>[

                  new Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/image3.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[

                              Container(
                                width: double.infinity,
                                height: 110,
                                child: SvgPicture.asset("assets/images/Holyhall_Logo.svg"),
                                  margin: EdgeInsets.only(top: 100),
                              ),

                              Expanded(
                                child: Container(),
                              ),



                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[

                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: designPatterns.inputLineWidget(theme: theme,
                                                                     controller: textFieldController,
                                                                     focusNode: focusTextWidget, 
                                                                     hintText: "Emailadresse",
                                                                     icon: Icons.mail),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(bottom: 40),
                                        child: designPatterns.inputLineWidget(theme: theme,
                                                                     controller: textFieldController,
                                                                     focusNode: focusTextWidget, 
                                                                     hintText: "Password",
                                                                     icon: Icons.lock_outline),
                                      ),
                                      

                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child:  designPatterns.customOutlineButton(text: "Einloggen"),
                                      ),

                                     
                                      
                                        

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0.0,vertical:20.0),
                                        child: Row(
                                          children: <Widget>[

                                            designPatterns.seperator(),
                                              
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                                              child: Text("oder", style: TextStyle(fontSize: 20.0,color: Colors.white),),
                                            ),

                                            designPatterns.seperator(),

                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            getSocialMediaBox("twitter"),
                                            getSocialMediaBox("twitter"),
                                            getSocialMediaBox("twitter"),

                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(top: 35),
                                        child:RichText(
                                          textAlign: TextAlign.center,
                                          
                                          text: TextSpan(
                                            style: TextStyle(color: Colors.white,fontSize: 13,height: 1.3),
                                            children: <TextSpan>[
                                              TextSpan(text: 'Du hast noch keinen Holyhall - Account ? Dann klicke jetzt '),
                                              TextSpan(text: 'HIER', style: TextStyle(fontWeight: FontWeight.bold)),
                                              TextSpan(text: ' um einen zu erstellen'),
                                            ],
                                          ),
                                        )
                                      )
                                     

                                      
                                    ] 
                                  ),
                                ),                              
                              ],
                            ),
                          
                ]
              ),
            ),
       ); 
  }

  Widget getSocialMediaBox(String type){
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0,color: Colors.white,style: BorderStyle.solid),
      ),
    );
  }
 
}