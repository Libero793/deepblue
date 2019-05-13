import 'dart:convert';

import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreenView extends HomeScreenState {

  @override
  Widget build(BuildContext context) {

    print("full$test");
    test++;
    //print("location${widget._currentLocation}");

    
    return new Scaffold(

      body: Stack(
        children: <Widget>[
          
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/startScreenBackgroundImage.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(48.0, 70.0, 48.0, 16.0),
                  child: Container(
                    height: 240,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        weatherWidget(),
                        infoTextWidget(),

                      ],
                    ),
                  ),
                ),

                spacerWidget(),

                loadingAnimationWidget(),

                locationSliderWidget(),
              ],
            ),
          ),

          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: new AppBar(
              title: new Text("", style: TextStyle(fontSize: 16.0),),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0.0,
              leading: new IconButton(
              icon: new Icon(Icons.menu,color: Colors.transparent,),
                onPressed: () {
                            
                },
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: new IconButton(
                    icon: new Icon(Icons.map),
                      onPressed: () {
                        if(washboxesLoaded && shootingsLoaded && eventsLoaded){
                          navigatorPushToMap();
                        }
                      },
                  )
                ),
              ],
            ),
          ),
          
          
    
        
        ]
      )
      

      //drawer: Drawer(),
    );    
  }


  Widget weatherWidget(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[

          Container(
            width: 70.0,
            height: 70.0,
            child: SvgPicture.asset(
              assetName,
              color: Colors.white,
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(temp, style: TextStyle(fontSize: 40.0, color: Colors.white, fontWeight: FontWeight.w400),),
                Text(" °C", style: TextStyle(fontSize: 26.0, color: Colors.white, fontWeight: FontWeight.w400,)),
              ]
            ),
          ),
               
        ]
      ),
    );
  }

  Widget infoTextWidget(){
    return Offstage(
      offstage: false,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,12.0),
            child: Text(welcomeTextHeadline, style: TextStyle(fontSize: 28.0, color: Colors.white, fontWeight: FontWeight.w400),),
          ),
      
          Text(welcomeText, style: TextStyle(color: Colors.white)),

        ],
      ),
    );
  }

  Widget spacerWidget(){
    print("height: ${MediaQuery.of(context).size.height}");

    if(initScrollSpacerHeight == -1){
      initScrollSpacerHeight = (((MediaQuery.of(context).size.height-510)).round()).toDouble();
      scrollSpacer=initScrollSpacerHeight;
    }


    
    return  AnimatedContainer(
              height: scrollSpacer,
              duration: new Duration(milliseconds: 300),
              color: Colors.transparent,
          );
  }

  Widget loadingAnimationWidget(){
    return Offstage(
      offstage: locationsLoaded,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: new CircularProgressIndicator(backgroundColor: Colors.white,valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
              height: 68.0,
              width: 68.0
            ),                    
          ],
        ),
      );
  }

  Widget locationSliderWidget(){
    return Expanded(
      child:  Offstage(
        offstage: (!locationsLoaded),
        child: Stack(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.fromLTRB(0.0, firstCardOffset, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child:  ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              controller: scrollControllerHorizontal,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, position) {
                                setupHorizontal(context);
                                return itemList(position);
                              },
                            ),
                  ),
                ],
              ),
            ),

            navBarSliderWidget(),

          ] 
        ),               
      ),
    );
  }

  Widget navBarSliderWidget(){
    return Padding(
              padding: EdgeInsets.fromLTRB(9.0, 0.0, 9.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                
                children: <Widget>[
                  Expanded(
                    child:  Container(
                      color: Colors.transparent,
                      height: 45.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[

                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  currentCard="event";
                                  scrollControllerHorizontal.animateTo(getScrollToPosition(MediaQuery.of(context).size.width,"event",0), duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getNavCardColor("event"),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    bottomLeft: const Radius.circular(10.0),
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      size: 28.0,
                                      color: getNavIconColor("event"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  currentCard="washbox";
                                  scrollControllerHorizontal.animateTo(getScrollToPosition(MediaQuery.of(context).size.width,"washbox",1), duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getNavCardColor("washbox"),                             
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Icon(
                                      Icons.local_car_wash,
                                      size: 28.0,
                                      color: getNavIconColor("washbox"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  currentCard="shootingspot";
                                  scrollControllerHorizontal.animateTo(getScrollToPosition(MediaQuery.of(context).size.width,"shootingspot",2), duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getNavCardColor("shootingspot"),
                                  borderRadius: BorderRadius.only(
                                    topRight: const Radius.circular(10.0),
                                    bottomRight: const Radius.circular(10.0),
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Icon(
                                      Icons.linked_camera,
                                      size: 28.0,
                                      color: getNavIconColor("shootingspot"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      
                                
                    )
                  ),
                ],
              ),
            );
  }


  Widget itemList(listPosition){

    var itemCount;
    switch (listPosition) {
      case 0:
          itemCount=nearLocations.eventsCount;
        break;
      case 1 : 
          itemCount=nearLocations.washboxenCount;
        break;
      case 2 :
          itemCount=nearLocations.shootingsCount;
        break;
      default:
    }
    return Container(
      width: (MediaQuery.of(context).size.width),
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: itemCount,
                        shrinkWrap: true,
                        controller: verticalScrolls[listPosition],
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, itemPosition) {
                          
                          return createListItem(listPosition, itemPosition);
                         
                        }
                      ),
                  ),
          ],
        ),
      )    
    );  
  }


Widget createListItem(listPosition, itemPosition){

    var locations;
    var locationImageExists = true;
    var locationType;
    switch (listPosition) {
      case 0:
        locations=nearLocations.events;
        locationType="events";
        break;
      case 1:
        locations=nearLocations.washboxen;
        locationType="washboxen";
        break;
      case 2:
        locations=nearLocations.shootings;
        locationType="shootings";
        break;
     default:
   }
   

   //print("testlocationscount: ${locationsJson}");
   
   if(locations != null){
        var locationName = locations[itemPosition]["name"];

        if(locationName.length > 21){
           locationName = locations[itemPosition]["name"].substring(0,22);
        }
       

        if(locations[itemPosition].containsKey("image")){
          locationImageExists = false;
        }
        
        return  GestureDetector(
                onTap: (){
                  widget.coreClass.callToShowMapLocation(locations[itemPosition],getNavCardColor(currentCard));
                  navigatorPushToMap();
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),

                      child: Container(
                        height: 115.0,
                        width: (MediaQuery.of(context).size.width -10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[

                            getLocationImageWidget(locations[itemPosition]["image"]),
                          

                            Expanded(
                              
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),      
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("$locationName",style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.w400)),

                                      
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                          child: Container(
                                            color: Colors.grey[300],
                                            height: 2.0,
                                            width: (MediaQuery.of(context).size.width - 170),
                                        ),
                                      ),
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                      
                                        children: <Widget>[

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[


                                              firstEntryListItem(locations[itemPosition],locationType),
                                              
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.golf_course, color: Colors.grey[500], size: 18.0,),
                                                    Padding(
                                                      padding: EdgeInsets.only( left: 5),
                                                      child: Text("${locations[itemPosition]["distanceText"]}",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.grey[400]))
                                                    )
                                                  ],
                                                )
                                              ),
                                            
                                            ],
                                          ),

                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                
                                                GestureDetector(
                                                  onTap: (){
                                                    launchMaps("${locations[itemPosition]["latitude"]}", "${locations[itemPosition]["longitude"]}");
                                                  },
                                                  child:  Padding(
                                                    padding:EdgeInsets.only(right: 5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(30),
                                                        border: Border.all(color: getNavCardColor(currentCard), width: 2.0)
                                                      ),
                                                      width: 40,
                                                      height: 40,
                                                      child: Icon(Icons.near_me,size: 25, color: getNavCardColor(currentCard)),
                                                    ),
                                                  )
                                                ),
                                              ],
                                            ),
                                          )
                                          


                                        ],
                                      ),
                                    ],

                                  )
                                )
                              ),
                          
                            

                            
                          ],
                        )
                        
                      
                        
                        
                      ),                                

                    )
                  ),
                );
   }else{
     return Container();                                    //insert Loading Icon here
   }
}

Widget firstEntryListItem(location, locationType){
  //print("test $location");

  if(locationType == "events"){
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Row(
        children: <Widget>[
          Icon(Icons.alarm_on, color: Colors.grey[500], size: 18.0,),
          Padding(
            padding: EdgeInsets.only( left: 5),
            child: Text(location["startTime"].substring(0,10),textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.grey[400]))
          ),
        ],
      ),
    );
  }else{
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Row(
        children: <Widget>[
          Icon(Icons.hourglass_empty, color: Colors.grey[500], size: 18.0,),
          Padding(
            padding: EdgeInsets.only( left: 5),
            child: Text("${location["durationText"]}",textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.grey[400]))
          ),
        ],
      ),
    );
  }
  
}

 getLocationImageWidget(imageBase64){


    if((imageBase64.toString()).length > 10){

      return  Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  decoration:  BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.grey[300],
                  image: new DecorationImage(
                    image: new MemoryImage(base64toBytes(imageBase64)),
                      fit: BoxFit.cover
                    ),              
                  ),      
                  height: 115.0,
                  width: 115.0,                            
                ),
              );
      
     
    }else{
      return  Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey[300],

                  ),      
                  height: 115.0,
                  width: 115.0,       
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[

                          Container(
                            width: 100,
                            height: 100,
                            padding:EdgeInsets.all(25),
                            child: Icon(Icons.camera_alt,color: Colors.grey,size: 50,),   
                          ),
                           
                          Icon(Icons.not_interested, color: Colors.grey, size:100),
                        ],
                      )
                  
                    ],
                  )
                  
                  
                                    
                ),
              );        
    }
    
  }

}