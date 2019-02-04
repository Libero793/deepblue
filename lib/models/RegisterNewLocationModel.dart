class RegisterNewLocationModel{

  Map<String,double> location;
  String locationName;

  bool hochdruckReiniger=false;
  bool schaumBuerste=false;
  bool schaumPistole=false;
  bool fliessendWasser=false;
  bool motorWaesche=false;

  void setLocation(loc){
    location = loc;
  }

  Map <String,double> getLocation(){
    return location;
  }

  void setLocationName(name){
    locationName = name;
  }

  String getLocationName(){
    return locationName;
  }

  //hochdruck Reiniger
  void setHochdruckReiniger(bool value){
    hochdruckReiniger = value;
  }

  bool getHochdruckReiniger(){
    return hochdruckReiniger;
  }


  //SchaumBuerste
  void setSchaumBuerste(bool value){
    schaumBuerste = value;
  }

  bool getSchaumBuerste(){
    return schaumBuerste;
  }


  //schaumPistole
  void setSchaumPistole(bool value){
    schaumPistole = value;
  }

  bool getSchaumPistole(){
    return schaumPistole;
  }


  //fliessendWasser
  void setFliessendWasser(bool value){
    fliessendWasser = value;
  }

  bool getFliessendWasser(){
    return fliessendWasser;
  }

  //motorWaesche
  void setMotorWaesche(bool value){
    motorWaesche = value;
  }

  bool getMotorWaesche(){
    return motorWaesche;
  }

}