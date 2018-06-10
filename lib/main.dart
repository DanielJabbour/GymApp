import 'package:flutter/material.dart'; //Import flutter package

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  //Override build method
  Widget build(BuildContext context) {
    //Creating a material app
    return new MaterialApp(
      home: new LoginPage(),
      theme: new ThemeData(
        primaryColor: Colors.black
      )
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  //Create a state class called loginpagestate
  State createState() => new LoginPageState();
}

//Create LoginPageState class inheriting state of login page
class LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    //Return a new app structure (AKA Scaffold)
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Container(),
    );
  }
}