import 'package:deepblue/new/userHandlingInterface/controller/registrationController.dart';
import 'package:deepblue/new/userHandlingInterface/controller/startController.dart';
import 'package:deepblue/new/commonInterface/view/patterns/designPatterns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartScreenView extends StartScreenController {

  DesignPatterns designPatterns = new DesignPatterns();
  double screenHeight = 0;
  GlobalKey _loginContainer =GlobalKey();
  GlobalKey _spacingContainer =GlobalKey();
  double loginContainerSpacingTop = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => (loginContainerSpacingTop=fixSpacing(_spacingContainer)));

  }
  

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
  
    if(MediaQuery.of(context).size.height>screenHeight){
      screenHeight=MediaQuery.of(context).size.height;
    }

    


    return Scaffold(
      resizeToAvoidBottomInset : false,
      resizeToAvoidBottomPadding : false,
       body: 
              Stack(                
                children: <Widget>[

                  backgroundImage(),

                  Container(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      logoImage(),


                      Expanded(
                        key: _spacingContainer,
                        child: Container(),
                      ),

                      Container(
                          margin: EdgeInsets.only(top: loginContainerSpacingTop),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.8),
                            ],
                            stops: [
                                  0.0,
                                  0.2,
                                  1.0
                                  ])
                             ),
                                    

                             child: Padding(
                              padding: EdgeInsets.fromLTRB(30,0, 30,0),
                              child: loginFormWidget(theme),
                            ),
                          ),   
                                               
                        ],
                      ),
                  )
                          
                ]
              ),
           

          
       
       ); 
  }

  Widget backgroundImage(){
    return 
    Positioned(
      top: 0.0,
      child: Image.asset(
        'assets/images/image3.jpg',
        fit: BoxFit.cover,
        
      ),
      height: screenHeight,
    );
  }

  Widget logoImage(){
    return
    Container(
      width: double.infinity,
      height: 110,
      child: SvgPicture.asset("assets/images/Holyhall_Logo.svg"),
        margin: EdgeInsets.only(top: 50),
    );
  }

  Widget loginFormWidget(theme){
    return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[

                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: designPatterns.inputLineWidget(theme: theme,
                                                                     controller: emailInputController,
                                                                     focusNode: emailInputWidget, 
                                                                     hintText: "Emailadresse",
                                                                     icon: Icons.mail),
                                  ),

                                  Padding(
                                        padding: EdgeInsets.only(bottom: 40),
                                        child: designPatterns.inputLineWidget(theme: theme,
                                                                     controller: passwortInputController,
                                                                     focusNode: passwordInputWidget, 
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

                                  GestureDetector(
                                    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen("mail")),); },
                                    child: Padding(
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
                                    ),
                                  )
                                      
                                ] 
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