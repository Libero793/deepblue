class NearLocations {
  List<dynamic> washboxen = null;
  List<dynamic> events = null;
  List<dynamic> shootings = null;

  var washboxenCount = 0;
  var eventsCount = 0;
  var shootingsCount = 0;

  bool washboxesInit = false;


  getNearLocations(int i){
    //if(i == 1){
      return washboxen;
    //}
      
  }


  void setCount(int i){
    washboxenCount = i;
  }

  void initWashboxes(){
    washboxesInit = true;
  }

  bool washboxesInitialized(){
    return washboxesInit;
  }


}