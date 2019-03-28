import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:deepblue/Views/homeScreenView.dart';
import 'package:deepblue/ViewModels/mapScreenState.dart';
import 'package:deepblue/models/CoreFunctionsModel.dart';
import 'package:deepblue/models/nearLocationsModel.dart';
import 'package:deepblue/models/setupFile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatefulWidget {

  CoreFunctionsModel coreClass;
  HomeScreen(this.coreClass);

  @override
  HomeScreenView createState() => new HomeScreenView();

}

abstract class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{


  var cardIndex = 0;
  ScrollController scrollControllerHorizontal;

  List verticalScrolls = [];
  int pagination = 0;
  int execution = 0;
  int test = 0;

  var currentColor = Colors.blue[900];
  var cardsList = [];
                  
  var cardColors = [];

  double scrollSpacer;
  double initScrollSpacerHeight;
  
  

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;
  Future httpReturn;
  int nearLocationsCount = 0;

  bool washboxesLoaded=false;
  bool eventsLoaded=false;
  bool shootingsLoaded=false;


  bool currentWidget = true;
  Image image1;
  String nearestLocationsJson;
  bool httpRequestExecuted = false;

  NearLocations nearLocations;

  

  Timer _reloadTimer;

  String currentCard;

  String temp ="-";
  String assetName = 'assets/images/Cloud.svg';
  String welcomeText = "-";
  String welcomeTextHeadline = "-";

  bool extendSpaceForScroll;
  bool horizontalScrollSetup=false;

  double firstCardOffset = 30.0;

  SetupFile fileHandler = new SetupFile();
 


  @override
  void initState() {
    initScrollSpacerHeight = -1; 
    
    if(!httpRequestExecuted){
      httpRequestLocations(widget.coreClass.getSelectedLocation(),"Waschboxen");
      httpRequestLocations(widget.coreClass.getSelectedLocation(),"Events");
      httpRequestLocations(widget.coreClass.getSelectedLocation(),"Shootings");
      httpRequestExecuted=true;
    }

    extendSpaceForScroll = false;
    scrollControllerHorizontal = new ScrollController();     
    nearLocations = new NearLocations();

    setupWeatherContext(widget.coreClass.getSelectedLocation());

    currentCard = "event";

    for(int i=0; i<=2; i++){
      addVerticalScrollController();
    }

    if(widget.coreClass.getHomeLocationTrigger()){
      writeHomeLocationToFile(widget.coreClass.getSelectedLocation());
      widget.coreClass.setAsHomeLocation=false;
    }
    
    super.initState();
  }

  Future writeHomeLocationToFile(positionMap) async {
    fileHandler.initFileDirectory().then((init){
      fileHandler.writeToFile("homeLocation", json.encode(positionMap));
    });
  }


  _verticalListener(){
    ScrollController verticalScroll = verticalScrolls[pagination];
      if(verticalScroll.offset>0){
        if(scrollSpacer != 0){
          setState(() {
            scrollSpacer = 0;
            firstCardOffset=50.0;    
          });
        }
      }else{
        if(scrollSpacer != initScrollSpacerHeight){
          setState(() {
            scrollSpacer = initScrollSpacerHeight;
            firstCardOffset= 30.0;  
          });
        }
      }
  }

  @override
  void dispose() {
    super.dispose();
    _reloadTimer.cancel();
  }

  Future setupWeatherContext(Map<String,double> location) async {
    if(httpRequestWeather(location) != "null"){
      var jsonWeather = await httpRequestWeather(location);
      var weather = json.decode(jsonWeather);
      print("jsonWeather $weather");

  
      switch (weather["currently"]["icon"]){
        case "cloudy": 
          assetName = 'assets/images/Cloud.svg';
          welcomeTextHeadline = "Gute Nachrichten";
          welcomeText = "Aktuell sind nur ein paar Wolken am Himmel - gutes Timing um dein Auto zu waschen!";

         break;

        case "clear-day": 
          assetName = 'assets/images/Sun.svg';
          welcomeTextHeadline = "Perfekt!";
          welcomeText ="Schnapp dir dein Auto - es ist perfektes Wetter um es zu waschen!";

         break;

        case "clear-night": 
          assetName = 'assets/images/Moon.svg';
          welcomeTextHeadline = "Perfekt!";
          welcomeText ="Wenn es dir nicht zu spät ist, ist das die perfekte Nacht um dein Auto zu waschen!";

         break;

        case "fog": 
          welcomeTextHeadline = "Ganz Gut!";
          welcomeText ="Aktuell ist es etwas nebelig draußen, aber wen hält das schon auf sein Auto zu waschen ?!";

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
          welcomeText ="Aktuell ist es etwas windig draußen, aber das ist für dich natürlich kein Grund dein Auto nicht zu waschen!";


         break;

        case "partly-cloudy-day": 
          assetName = 'assets/images/Cloud.svg';
          welcomeTextHeadline = "Gute Nachrichten";
          welcomeText ="Schnapp dir dein Auto - es sind nur wenige Wolken am Himmel!";

         break;

        case "partly-cloudy-night": 
          assetName = 'assets/images/Cloud-Moon.svg';
          welcomeTextHeadline = "Gute Nachrichten";
          welcomeText ="Schnapp dir dein Auto - es sind nur wenige Wolken am Himmel!";

         break;

      }

      if(weather["currently"]["temperature"] < 6){
        welcomeTextHeadline= "Das wird kalt!";
        welcomeText = "Aktuell ist es draußen ziemlich kalt, kein gutes Wetter um dein Auto zu waschen. Warte lieber noch bis das Wetter wieder besser wird.";
      }
      
      setState(() {
              temp = weather["currently"]["temperature"].toStringAsFixed(0);
            });

    }
  }

  Future<String> httpRequestWeather(Map<String,double> location)async {
    var darkSkyUrl="https://api.darksky.net/forecast/97ada79b0fdc34e056d1cdd1f41c6ddf/"
                   "${location['latitude']},${location['longitude']}"
                   "?units=auto";

    final res = await http.read(darkSkyUrl);
    return res;
  }

  void httpRequestLocations(var location, var type)async {
    print("httploc ${location}");

    var url = "http://www.nell.science/deepblue/index.php";

    http.post(url, body: {"getLocations":"true","key": "0", "latitude": location['latitude'].toString(), "longitude": location['longitude'].toString(), "type":type.toString(), })
        .then((response) {
      print("Response status: ${response.statusCode}");   
      print("Response body: ${response.body}");

      if (this.mounted){
        if(response.body != "null"){

          var nearestLocation;
          var nearestLocationsJson = "";

          nearestLocationsJson = response.body.toString();
          nearestLocation=json.decode(nearestLocationsJson);
          nearLocationsCount=json.decode(nearestLocationsJson).length;

          setState((){

                  if(type=="Waschboxen"){
                    nearLocations.washboxen=nearestLocation;
                    nearLocations.washboxenCount=json.decode(response.body.toString()).length;
                    washboxesLoaded=true;
                  }else if (type=="Events"){
                    nearLocations.events=nearestLocation;
                    nearLocations.eventsCount=json.decode(response.body.toString()).length;
                    eventsLoaded=true;
                  }else if(type=="Shootings"){
                    nearLocations.shootings=nearestLocation;
                    nearLocations.shootingsCount=json.decode(response.body.toString()).length;
                    shootingsLoaded=true;
                  }
                  
              });

        }else{
          print("reload 3000ms");
          _reloadTimer = new Timer(const Duration(milliseconds: 3000), () {
            httpRequestLocations(location,type);
          });  
        }
       
      }

    });
    
  }

  Color getNavCardColor(navSelected){
   if(navSelected == currentCard){
     switch (navSelected) {
       case "event":
          return widget.coreClass.eventColor;
         break;
       case "washbox":
          return widget.coreClass.washboxColor;
         break;
       case "shootingspot":
          return widget.coreClass.shootingColor;
       default:
     }
   }else{
     return Colors.white;
   }
  }

  IconData getNavIcon(locationType){
    if(locationType == "washbox"){
      return Icons.local_car_wash;
    }
    if(locationType == "event"){
      return Icons.star;
    }
    if(locationType == "shootingspot"){
      return Icons.linked_camera;
    }
  }

  double getNavIconSize(navSelected){
    if(navSelected == currentCard){
      return 40.0;
    }else{
      return 25.0;
    }
  }

  double getNavIconBoxSize(navSelected){
    if(navSelected == currentCard){
      return 65.0;
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
      return Colors.blue[400];
    }else{
      return Colors.grey[200];
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
      if(navSelected == "event"){
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
      //scrollControllerHorizontal.animateTo(MediaQuery.of(context).size.width, duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
      horizontalScrollSetup=true;
    }
  }

  void navigatorPushToMap(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen(widget.coreClass,nearLocations)),
    );
  }

  launchMaps(lat,lng) async {

    print("launchMaps");
    String googleMapsAndroidUrl ='google.navigation:q=${lat},${lng}';
    String googleMapsIosUrl ='comgooglemaps://?q=<$lat>,<$lng>';
    String appleUrl = 'https://maps.apple.com/?sll=${lat},${lng}';

   
    /// Documentation :
    /// Google Maps in a browser: "http://maps.google.com/?q=<lat>,<lng>"
    /// Google Maps app on an iOS mobile device : "comgooglemaps://?q=<lat>,<lng>"
    /// Google Maps app on Android : "geo:<lat>,<lng>?z=<zoom>"
    /// You can also use "google.navigation:q=latitude,longitude"
    /// z is the zoom level (1-21) , q is the search query
    /// t is the map type ("m" map, "k" satellite, "h" hybrid, "p" terrain, "e" GoogleEarth)
    if (await canLaunch(googleMapsAndroidUrl)) {

      print('launching google Maps Android Navigation');
      await launch(googleMapsAndroidUrl);

    } else if (await canLaunch(googleMapsIosUrl)) {

      print('launching google Maps Ios Navigation');
      await launch(googleMapsIosUrl);

    } else if (await canLaunch(appleUrl)) {

      print('launching apple url');
      await launch(appleUrl);

    } else {
      throw 'Could not launch url';
    }

  }

  Uint8List base64toBytes(imageString){
    if(imageString != null){
      Uint8List bytes = base64Decode(imageString);
      return bytes;
    }
  }



}

 
