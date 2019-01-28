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
      httpRequestLocations(widget.positionMap);
      httpRequestExecuted=true;
    }
    
    return new Scaffold(
      backgroundColor: currentColor,
      appBar: new AppBar(
        title: new Text("", style: TextStyle(fontSize: 16.0),),
        backgroundColor: currentColor,
        centerTitle: true,
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
        elevation: 0.0,
      ),


      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 32.0, 48.0, 32.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                          Container(
                            width: 60.0,
                            height: 60.0,
                            child: SvgPicture.asset(
                                      assetName,
                                      color: Colors.white,
                                    ),
                          ),


                          Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Text(temp, style: TextStyle(fontSize: 38.0, color: Colors.white, fontWeight: FontWeight.w400),),
                                Text(" °C", style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w400,)),
                              ]
                            ),
                          ),

                          

                        ]
                      ),
                    ),

                    Offstage(
                      offstage:extendSpaceForScroll,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,12.0),
                            child: Text(welcomeTextHeadline, style: TextStyle(fontSize: 28.0, color: Colors.white, fontWeight: FontWeight.w400),),
                          ),
                          Text(pagination.toString(), style: TextStyle(color: Colors.white),),
                          Text("", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),

            Offstage(
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
            ),


            Expanded(
              child:  Offstage(
                offstage: (!washboxesLoaded),
                child: Stack(
                  children: <Widget>[


                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child:
                              ListView.builder(
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
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        navIcon("gasstation",0),
                        navIcon("washbox",1),
                        navIcon("shootingspot",2),
                      ],
                    )
                    
                

                  ] 
                ),               
              ),
            ),
          ],
        ),
      ),
      //drawer: Drawer(),
    );    
  }

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
            borderRadius: BorderRadius.circular(15.0)
          ),
        ),
      ),
    );    
  }


  Widget itemList(listPosition){
    print(execution);
    execution++;
    return Container(
      width: (MediaQuery.of(context).size.width),
      color: Colors.grey[200],
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
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
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                              child: Card(
                                color: getCardColor(listPosition),
                                shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)
                                ),

                                child: Container(
                                  height: 200.0,
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