
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';

class SetupFile {

  File jsonFile;
  String filePath;
  bool fileExists = false;
  Map <String, dynamic> fileContent;
  String fileName = "deepblueSetup.json";

  Future initFileDirectory() async {

    String path = await getFilePath();
    print(path);
    jsonFile = new File(path + "/" + fileName);
    if(jsonFile.existsSync()){
      fileExists=true;
    }

  }

  Future<String> getFilePath() async {

    Directory tempDir = await getApplicationDocumentsDirectory();
    return tempDir.path;

  }

  bool checkIfFileExists(){
    if(fileExists){
      return true;
    }else{
      return false;
    }
  }

  void writeToFile(String key, dynamic value){
    Map<String,dynamic> content = {key:value};
    if(fileExists){
      print("fileExists - write to SetupFile");
      Map<String,dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    }else{
      print("createFile");
      createFile(content);
    }
  }

  Future createFile(Map<String,dynamic> content) async {
    String path = await getFilePath();
    File file = new File(path +"/"+ fileName);
    file.createSync();
    fileExists=true;
    file.writeAsStringSync(json.encode(content));
    print("file created");
  }

  Map <String, dynamic> readOutSetupFile(path){
    File file = new File(path +"/"+ fileName);
    fileContent = json.decode(file.readAsStringSync());
    return fileContent;
  }


}