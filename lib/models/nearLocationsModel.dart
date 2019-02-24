class NearLocations {
  var washboxen;
  bool washboxesInit=false;

  void setNearWashboxes(var locations){
    washboxen = locations;
  }

  String getNearWashboxes(){
    return washboxen;
  }

  int getCount(int listPosition){
      return 3;
    
    
  }

  void initWashboxes(){
    washboxesInit = true;
  }

  bool washboxesInitialized(){
    return washboxesInit;
  }


}