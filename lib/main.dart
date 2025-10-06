import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main(){
  var app = App();
  runApp(app);
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Selamat Datang"),),
    );
  }
}

