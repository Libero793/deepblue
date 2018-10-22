import 'dart:core';

class RegisterLocationModel {

  bool hochdruckReiniger;
  bool schaumBuerste;
  bool schaumPistole;
  bool fliessendWasser;
  bool motorWaesche;

  RegisterLocationModel(this.hochdruckReiniger, this.schaumBuerste, this.schaumPistole, this.fliessendWasser, this.motorWaesche);

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