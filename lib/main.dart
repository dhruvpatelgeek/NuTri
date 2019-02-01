import 'package:nutri/fab.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:nutri/home.dart';
import 'package:nutri/profile.dart';
import 'package:nutri/stats.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutri/entries.dart';

void main() => runApp(new MyApp());

int percentage = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'NuTri',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'NuTri'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Key key;
  MyHomePage({this.key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState(key);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _lastSelected = 0;
  File _image;
  Key key;

  int getPercentage() {
    return percentage;
  }

  _MyHomePageState(this.key);

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  Widget _buildBody() {
    switch (_lastSelected) {
      case 0:
        return Home();
      case 1:
      return Entries();
      case 2:
        return Stats(getPercentage,key);
      case 3:
        return Profile();
    }
    return Center(
      child: Text(
        '$_lastSelected',
        style: TextStyle(fontSize: 32.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // title: Text(widget.title),

      // ),
      body: _buildBody(),

      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: Colors.redAccent,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(iconData: Icons.list, text: 'Entries'),
          FABBottomAppBarItem(iconData: Icons.graphic_eq, text: 'Stats'),
          FABBottomAppBarItem(iconData: Icons.person_outline, text: 'Profile'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
    );
  }

  Future analyseImage(_image) async {
    String apiUrl = 'https://westus.api.cognitive.microsoft.com/vision/v1.0/analyze?visualFeatures=Categories&language=en';
  var imageFile = _image;

  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var uri = Uri.parse(apiUrl);

     var request = new http.MultipartRequest("POST", uri);

      request.headers['Content-type'] = 'application/octet-stream';
      request.headers['ocp-apim-subscription-key'] = 'f0b065f80f0d406181bc5eb44108c099';

      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: basename(imageFile.path));

      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        value = value.toLowerCase();
        print(value);
        // if (value.contains("text")) {
          return analyseText(_image);
        // } 
        // else 
        // if(value.contains("fruit") || value.contains("food") || value.contains("vegetable")) 
        // {
        //     analysePhysicalObject(_image);
        // }
      });
}

Future analyseText(_image) async {
  String apiUrl = 'https://westus.api.cognitive.microsoft.com/vision/v1.0/ocr?language=unk&detectOrientation =true';
  var imageFile = _image;

  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var uri = Uri.parse(apiUrl);

     var request = new http.MultipartRequest("POST", uri);

      request.headers['Content-type'] = 'application/octet-stream';
      request.headers['ocp-apim-subscription-key'] = 'f0b065f80f0d406181bc5eb44108c099';

      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: basename(imageFile.path));

      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        setState(() {
          moreAnalyseText(value);
        });
      });
}

void moreAnalyseText(String text){
  print(text);
  text = text.replaceAll(" ", '').toLowerCase();
  String needed = "";
  List<String> words = List<String>();
  int j=0;
  words.add("");
  for(int i=0; i<text.length; i++) {
  String char = text[i];
  // print(char);
  if(needed == "text\":\"" && char == "\"") {
    needed = "";
    j++;
    words.add("");
  }
  else if(needed == "text\":\"")
    words[j] += char;
  else if(needed == "text\":" && char == "\"") 
    needed += char;

  else if(needed == "text\"" && char == ":") 
    needed += char;
  else if(needed == "text" && char == "\"") 
    needed += char;
  else if(needed == "tex" && char == "t") 
    needed += char;
  else if(needed == "te" && char == "x")
    needed += char;
  else if(needed == "t" && char == "e")
    needed += char;
  else if(needed == "" && char == "t")
    needed += char;

} 
  bool temp = false;
  for(int i =0; i<words.length; i++) {
    var f = words[i];
    if(f.contains("calor") ) {
      temp = true;
    }
    if(temp) {
      int cal = int.tryParse(f)??0;
      if(cal!=0) {
        setState(() {
          percentage += cal;
        });
        Fluttertoast.showToast(msg: "Ahh, this thing is worth $cal calories.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2);
        break;
      }
    }
  }

  print(words);
  
}

Future analysePhysicalObject(_image) async {
  String apiUrl = 'https://westus.api.cognitive.microsoft.com/vision/v1.0/describe?maxCandidates=1';
  var imageFile = _image;

  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var uri = Uri.parse(apiUrl);

     var request = new http.MultipartRequest("POST", uri);

      request.headers['Content-type'] = 'application/octet-stream';
      request.headers['ocp-apim-subscription-key'] = 'f0b065f80f0d406181bc5eb44108c099';

      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: basename(imageFile.path));

      request.files.add(multipartFile);
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
          setState(() {
            
              if(!moreAnalysePhysicalValue(value.toLowerCase())) {
                analyseImage(_image);
              }
          });
      });
}


bool moreAnalysePhysicalValue(String text) {
  print(text);
  int thresh = 70;
  String msg = "";
  bool tr = false;
  int calories;
  int ind = -1;
  if(text.indexOf("pizza")!=-1 ) {
    tr = true;
    ind = text.indexOf("pizza");
    msg = "Hey you ate a pizza worth 285 calroies";
    calories = 285;
  } if(text.indexOf("banana")!=-1) {

    int temp = text.indexOf("banana");
    if(ind!=-1) {
      if(temp<ind) {
    tr = true;
    calories = 105;
    ind = temp;
    msg = "That tasty banana got you 105 calories";
      }
    } else {

    tr = true;
    calories = 105;
    ind = temp;
    msg = "That tasty banana got you 105 calories";
    }
  } if(text.indexOf("apple")!=-1) {

    int temp = text.indexOf("apple");
    if(ind!=-1) {
    if (temp<ind) {

    tr = true;
    calories = 95;
    msg = "95 calories from that apple will keep you away from the doctor";
    ind = temp;
    } } else {

    tr = true;
    calories = 95;
    msg = "95 calories from that apple will keep you away from the doctor";
    ind = temp;
    }
  }
  if(ind<thresh && ind!=-1) {
    setState(() {
          percentage += calories;
        });
    Fluttertoast.showToast(msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2);
        return true;
  } else {
    print(text);
    return false;
    // moreAnalyseText(text);
  }

  
}

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 2500, maxHeight: 2500);

    setState(() {
      _image = image; 
      analysePhysicalObject(_image);
      
    });
  }

  Widget _buildFab(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return showFab
        ? FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Increment',
            backgroundColor: Colors.grey,
            child: Icon(Icons.camera),
            elevation: 2.0,
          )
        : null;
  }
}
  