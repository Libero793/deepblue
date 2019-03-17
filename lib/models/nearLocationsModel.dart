class NearLocations {
  List<dynamic> washboxen = null;
  var washboxenCount = 0;
  bool washboxesInit = false;

  void setNearWashboxes(var locations){
    washboxen = locations;
  }

  getNearLocations(int i){
    //if(i == 1){
      return washboxen;
    //}
      
  }

  int getCount(int listPosition){
    if(listPosition == 1){
      return washboxenCount;
    }else{
      return 5;
    }
      
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