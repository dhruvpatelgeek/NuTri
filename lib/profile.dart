import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  _ProfileState() {
    _loadData("email").then((value) {
      setState(() {
        emailController.text = value;
      });
    });
    _loadData("password").then((value) {
      setState(() {
        passController.text = value;
      });
    });
    _loadData("age").then((value) {
      setState(() {
        ageController.text = value;
      });
    });
    _loadData("height").then((value) {
      setState(() {
        heightController.text = value;
      });
    });
    _loadData("weight").then((value) {
      setState(() {
        weightController.text = value;
      });
    });
  }

  void _saveData(String pref, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(pref, data);
  }

  Future<String> _loadData(String pref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(pref);
  }

  var emailController = new TextEditingController();
  var passController = new TextEditingController();
  var ageController = new TextEditingController();
  var heightController = new TextEditingController();
  var weightController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Center(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    image:
                        DecorationImage(image: AssetImage("assets/male.png")),
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Center(
            child: Text(
              "Jason Mark",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: passController,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (val) =>
                        val.length < 4 ? 'Password too short..' : null,
                    // onSaved: (val) => _password = val,
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      suffixText: 'years',
                    ),
                  ),
                  TextFormField(
                    controller: heightController,
                    decoration: InputDecoration(
                      labelText: 'Height',
                      suffixText: 'cm',
                    ),
                  ),
                  TextFormField(
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                      suffixText: 'kg',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  RaisedButton(
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.grey,
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    onPressed: () {
                      setState(() {
                        _saveData("email", emailController.text);
                        _saveData("password", passController.text);
                        _saveData("age", ageController.text);
                        _saveData("weight", weightController.text);
                        _saveData("height", heightController.text);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
