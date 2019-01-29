import 'dart:async';
import 'dart:convert';
import 'package:deepblue/Views/homeScreenView.dart';
import 'package:deepblue/ViewModels/mapScreenState.dart';
import 'package:flutter/material.dart';
import 'package:deepblue/models/CardItemModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';


class HomeScreen extends StatefulWidget {

  Map<String, double> positionMap;
  HomeScreen(this.positionMap);

  @override
  HomeScreenView createState() => new HomeScreenView();

}

abstract class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{


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

    setupWeatherContext(widget.positionMap);

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
      if(verticalScroll.offset>10){
        setState(() {
          extendSpaceForScroll=true;       
        });
        
      }
    }else{
      if(verticalScroll.offset<=10){
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
          welcomeTextHeadline = "Gute Nachrichten";
          welcomeText = "Aktuell sind nur ein paar Wolken am Himmel - gutes Timing um dein Auto zu waschen! Dazu haben wir $nearLocationsCount Waschboxen in deiner Nähe gefunden.";

         break;

        case "clear-day": 
          assetName = 'assets/images/Sun.svg';
          welcomeTextHeadline = "Perfekt!";
          welcomeText ="Schnapp dir dein Auto - es ist perfektes Wetter um es zu waschen! Dazu haben wir $nearLocationsCount Waschboxen in deiner Nähe gefunden.";

         break;

        case "clear-night": 
          assetName = 'assets/images/Moon.svg';
          welcomeTextHeadline = "Perfekt!";
          welcomeText ="Wenn es dir nicht zu spät ist, ist das die perfekte Nacht um dein Auto zu waschen! Dazu haben wir $nearLocationsCount Waschboxen in deiner Nähe gefunden.";

         break;

        case "rain": 
          assetName = 'assets/images/Cloud-Rain.svg';
          welcomeTextHeadline = "Lieber abwarten!";
          welcomeText ="Aktuell sieht es am Himmel sehr nach Regen aus, warte lieber noch etwas ab! Warte lieber noch bis das Wetter wieder besser wird.";

         break;

        case "snow": 
          assetName = 'assets/images/Cloud-Snow.svg';
          welcomeTextHeadline = "Das wird kalt!";
          welcomeText ="Aktuell sieht es nach Schnee aus, das ist kein gutes Wetter um dein Auto zu waschen. Warte lieber noch bis das Wetter wieder besser wird.";

         break;

        case "wind": 
          assetName = 'assets/images/Wind.svg';
          welcomeTextHeadline = "Achtung Windig!";
          welcomeText ="Aktuell ist es etwas windig draußen, aber das ist für dich natürlich kein Grund dein Auto nicht zu waschen! Dazu haben wir $nearLocationsCount Waschboxen in deiner Nähe gefunden.";


         break;

        case "partly-cloudy-day": 
          assetName = 'assets/images/Cloud.svg';
          welcomeTextHeadline = "Gute Nachrichten";
          welcomeText ="Schnapp dir dein Auto - es sind nur wenige Wolken am Himmel! Dazu haben wir $nearLocationsCount Waschboxen in deiner Nähe gefunden.";

         break;

        case "partly-cloudy-night": 
          assetName = 'assets/images/Cloud-Moon.svg';
          welcomeTextHeadline = "Gute Nachrichten";
          welcomeText ="Schnapp dir dein Auto - es sind nur wenige Wolken am Himmel! Dazu haben wir $nearLocationsCount Waschboxen in deiner Nähe gefunden.";

         break;

      }

      if(weather["currently"]["temperature"] < 6){
        welcomeTextHeadline= "Das wird kalt!";
        welcomeText = "Aktuell ist es draußen ziemlich kalt, kein gutes Wetter um dein Auto zu waschen. Warte lieber noch bis das Wetter wieder besser wird.";
      }

      if(nearLocationsCount < 1){
        welcomeTextHeadline= "Sorry!";
        welcomeText = "Leider haben wir keine Waschboxen in deiner Nähe gefunden. Wechsel in die Karte um alle Waschboxen zu sehen oder neue hinzuzufügen";
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
      return Colors.grey[600];
    }

    if(position == 1){
      return Colors.grey[800];
    }

    if(position == 2){
      return Colors.grey[700];
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
      return Icons.linked_camera;
    }
  }

  double getNavIconSize(navSelected){
    if(navSelected == currentCard){
      return 45.0;
    }else{
      return 25.0;
    }
  }

  double getNavIconBoxSize(navSelected){
    if(navSelected == currentCard){
      return 70.0;
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
      return Colors.red;
    }else{
      return Colors.grey[600];
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

  void navigatorPushToMap(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen(widget.positionMap)),
    );
  }



}

 
