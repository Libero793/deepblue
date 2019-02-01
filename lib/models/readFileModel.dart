
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';

class ReadFile {

  File jsonFile;
  Directory dir;
  bool fileExists = false;
  Map <String, dynamic> fileContent;

  void initFileDirectory(fileName){
    try{
      getApplicationDocumentsDirectory().then((Directory directory){
        dir = directory;
        jsonFile = new File(dir.path + "/" + fileName);
        fileExists = jsonFile.existsSync();
        if(fileExists) {
          fileContent = json.decode(jsonFile.readAsStringSync());
        }
      });
    }catch(Exception){
          print(Exception);
    }
    
  }

  bool checkIfFileExists(fileName){
    if(fileExists){
      return true;
    }else{
      return false;
    }
  }

  Map <String, dynamic> getFileContent(file){
    fileContent = json.decode(file.readAsStringSynch());
    return fileContent;
  }


}