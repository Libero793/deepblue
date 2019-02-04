import 'package:deepblue/ViewModels/homeScreenState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreenView extends HomeScreenState {

  @override
  Widget build(BuildContext context) {

    print("full$test");
    test++;
    //print("location${widget._currentLocation}");
    if(!httpRequestExecuted){
      httpRequestLocations(widget.coreClass.getSelectedLocation());
      httpRequestExecuted=true;
    }
    
    return new Scaffold(

      body: Stack(
        children: <Widget>[
          
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/backgroundImageTest.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(48.0, 70.0, 48.0, 16.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        weatherWidget(),
                        infoTextWidget(),

                      ],
                    ),
                  ),
                ),

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
              icon: new Icon(Icons.menu),
                onPressed: () {
                            
                },
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: new IconButton(
                    icon: new Icon(Icons.map),
                      onPressed: () {
                        navigatorPushToMap();
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
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 0.0),
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
          Offstage(
            offstage: extendSpaceForScroll,
            child:Container(
              height: 270.0,
            )
          )
        ],
      ),
    );
  }

  Widget loadingAnimationWidget(){
    return Offstage(
      offstage: washboxesLoaded,
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
        offstage: (!washboxesLoaded),
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
                                  currentCard="gasstation";
                                  scrollControllerHorizontal.animateTo(getScrollToPosition(MediaQuery.of(context).size.width,"gasstation",0), duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getNavCardColor("gasstation"),
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
                                      Icons.local_gas_station,
                                      size: 28.0,
                                      color: getNavIconColor("gasstation"),
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
                                  scrollControllerHorizontal.animateTo(getScrollToPosition(MediaQuery.of(context).size.width,"washbox",1), duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
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
                                  scrollControllerHorizontal.animateTo(getScrollToPosition(MediaQuery.of(context).size.width,"shootingspot",2), duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
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

  /*
  Widget navIcon(locationType,index){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(

        onTap: (){
          setState(() {
            currentCard=locationType;
            scrollControllerHorizontal.animateTo(getScrollToPosition(MediaQuery.of(context).size.width,locationType,index), duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
          });
        },

        child: Card(
          child: Container(
            width: getNavIconBoxSize(locationType),
            height: getNavIconBoxSize(locationType),
            child: Icon(
              getNavIcon(locationType),
              color: getNavIconColor(locationType),
              size: getNavIconSize(locationType),
            ),
          ),
          
          color: getNavIconBoxColor(locationType),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
        ),
      ),
    );    
  }
  */

  Widget itemList(listPosition){
    print(execution);
    execution++;
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
                        itemCount: 10,
                        shrinkWrap: true,
                        controller: verticalScrolls[listPosition],
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, itemPosition) {
                          
                          return  Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                ),

                                child: Container(
                                  height: 175.0,
                                ),                                

                              )
                          );
                        }
                      ),
                  ),
          ],
        ),
      )    
    );  
  }

/*
  Widget locationList(position){
    return Card(
                                child: Container(
                                  width: 250.0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(cardsList[position].icon, color: Colors.blue[900],),
                                            Icon(Icons.more_vert, color: Colors.grey,),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                              child: Text("${cardsList[position].distance}", style: TextStyle(color: Colors.grey),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                              child: Text("${cardsList[position].cardTitle}", style: TextStyle(fontSize: 28.0),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: LinearProgressIndicator(value: cardsList[position].taskCompletion,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                              );

  }*/

}