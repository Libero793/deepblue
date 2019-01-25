import 'dart:async';
import 'dart:convert';
import 'package:deepblue/screens/mapScreen.dart';
import 'package:deepblue/screens/locatingScreen.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/models/CardItemModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';



class HomeScreen extends StatefulWidget {
  var positionMap = new Map<String,double>();
  
  HomeScreen(this.positionMap);

  @override
  _HomeScreenState createState() => new _HomeScreenState(positionMap);
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{


  var cardIndex = 0;
  ScrollController scrollControllerHorizontal;

  List verticalScrolls = [];
  int pagination = 1;
  int execution = 0;
  int test = 0;

  var currentColor = Colors.blue[900];
  var cardsList = [];
                  
  var cardColors = [];
  

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;
  Future httpReturn;
  int nearLocationsCount = 0;

  bool washboxesLoaded=false;

  bool currentWidget = true;
  Image image1;
  String nearestLocationsJson;
  bool httpRequestExecuted = false;

  var positionMap = new Map<String,double>();
  _HomeScreenState(this.positionMap);

  Timer _reloadTimer;

  String currentCard;

  String temp ="-";
  String assetName = 'assets/images/Cloud.svg';
  String welcomeText = "-";
  String welcomeTextHeadline = "-";

  bool extendSpaceForScroll;
  bool horizontalScrollSetup=false;
 


  @override
  void initState() {
    extendSpaceForScroll = false;
    scrollControllerHorizontal = new ScrollController();     

    setupWeatherContext(positionMap);

    currentCard = "washbox";

    for(int i=0; i<=2; i++){
      addVerticalScrollController();
    }
    
    super.initState();
  }


  _verticalListener(){
    ScrollController verticalScroll = verticalScrolls[pagination];
    print(verticalScroll.offset);

    if(!extendSpaceForScroll){
      if(verticalScroll.offset>0){
        setState(() {
          extendSpaceForScroll=true;       
        });
        
      }
    }else{
      if(verticalScroll.offset==0){
        setState(() {
          extendSpaceForScroll=false;       
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _reloadTimer.cancel();
  }

  Future setupWeatherContext(var location) async {
    if(httpRequestWeather(location) != "null"){
      var jsonWeather = await httpRequestWeather(location);
      var weather = json.decode(jsonWeather);
      print("jsonWeather $weather");

  
      switch (weather["currently"]["icon"]){

        case "cloudy": 
          assetName = 'assets/images/Cloud.svg';
         break;
        
        case "clear-day": 
          assetName = 'assets/images/Sun.svg';
         break;

        case "clear-night": 
          assetName = 'assets/images/Moon.svg';
         break;

        case "rain": 
          assetName = 'assets/images/Cloud-Rain.svg';
         break;

        case "snow": 
          assetName = 'assets/images/Cloud-Snow.svg';
         break;

        case "wind": 
          assetName = 'assets/images/Wind.svg';         
         break;
        
        case "partly-cloudy-day": 
          assetName = 'assets/images/Cloud.svg';         
         break;
        
        case "partly-cloudy-night": 
          assetName = 'assets/images/Cloud-Moon.svg';         
         break;

      }
      setState(() {
              temp = weather["currently"]["temperature"].toStringAsFixed(0);
            });

    }
  }

  Future<String> httpRequestWeather(var location)async {
    var darkSkyUrl="https://api.darksky.net/forecast/97ada79b0fdc34e056d1cdd1f41c6ddf/"
                   "${location['latitude']},${location['longitude']}"
                   "?units=auto";

    final res = await http.read(darkSkyUrl);
    return res;
  }

  void httpRequestLocations(var location)async {
    print("httploc ${location}");

    var url = "http://www.nell.science/deepblue/index.php";

    http.post(url, body: {"getWashboxesHomescreen":"true","key": "0", "latitude": location['latitude'].toString(), "longitude": location['longitude'].toString(), "limit":"5"})
        .then((response) {
      print("Response status: ${response.statusCode}");   
      print("Response body: ${response.body}");

      if (this.mounted){
        if(response.body != "null"){

          var nearestLocation;
          var nearestLocationsJson = "";
          var distanceIndicator;
          var biggestDistance;

          nearestLocationsJson = response.body.toString();
          nearestLocation=json.decode(nearestLocationsJson);
          nearLocationsCount=json.decode(nearestLocationsJson).length;
          biggestDistance=nearestLocation[nearLocationsCount-1]["distanceValue"];

          print("biggestDistance$biggestDistance");

          setState((){
                  for(int i=0;i<nearestLocation.length;i++){
                    distanceIndicator=(nearestLocation[i]["distanceValue"]/biggestDistance);
                    cardsList.add(CardItemModel(nearestLocation[i]["name"], Icons.local_car_wash, nearestLocation[i]["distanceText"], distanceIndicator));
                  }
                  washboxesLoaded=true;
              });
        }else{
          print("reload 3000ms");
          _reloadTimer = new Timer(const Duration(milliseconds: 3000), () {
            httpRequestLocations(location);
          });  
        }
       
      }

    });
    
  }

  Color getCardColor(position){
    if(position == 0){
      return Colors.blue;
    }

    if(position == 1){
      return Colors.green;
    }

    if(position == 2){
      return Colors.yellow;
    }
  }

  IconData getNavIcon(locationType){
    if(locationType == "washbox"){
      return Icons.local_car_wash;
    }
    if(locationType == "gasstation"){
      return Icons.local_gas_station;
    }
    if(locationType == "shootingspot"){
      return Icons.camera_alt;
    }
  }

  double getNavIconSize(navSelected){
    if(navSelected == currentCard){
      return 35.0;
    }else{
      return 25.0;
    }
  }

  double getNavIconBoxSize(navSelected){
    if(navSelected == currentCard){
      return 60.0;
    }else{
      return 50.0;
    }
  }

  Color getNavIconColor(navSelected){
    if(navSelected == currentCard){
      return Colors.white;
    }else{
      return Colors.grey[400];
    }
  }

  Color getNavIconBoxColor(navSelected){
    if(navSelected == currentCard){
      return Colors.blue;
    }else{
      return Colors.white;
    }
  }

  double getScrollToPosition(screenWidth,navSelected,index){
    print(index);
    if(index != pagination){

      setState(() {
        pagination = index;
      });

      if(navSelected == "washbox"){
        return screenWidth*1;
      }
      if(navSelected == "gasstation"){
        return screenWidth*0;
      }
      if(navSelected == "shootingspot"){
        return screenWidth*2;
      }      
    }
  }

  ScrollController addVerticalScrollController(){
        verticalScrolls.add(new ScrollController());
        addScrollControllerListener();
        return verticalScrolls.last;
  }

  void addScrollControllerListener(){
    verticalScrolls.last.addListener(_verticalListener);
  }

  void setupHorizontal(context){
    if(!horizontalScrollSetup){
      scrollControllerHorizontal.animateTo(MediaQuery.of(context).size.width, duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
      horizontalScrollSetup=true;
    }
  }





  @override
  Widget build(BuildContext context) {

    print("full$test");
    test++;
    //print("location${widget._currentLocation}");
    if(!httpRequestExecuted){
      httpRequestLocations(positionMap);
      httpRequestExecuted=true;
    }
    
    return new Scaffold(
      backgroundColor: currentColor,
      appBar: new AppBar(
        title: new Text("DeepBlue", style: TextStyle(fontSize: 16.0),),
        backgroundColor: currentColor,
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.map),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => mapScreen(positionMap)),
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocatingScreen()),
                );
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

 
