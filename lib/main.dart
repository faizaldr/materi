import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  var app = App();
  runApp(app);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var n = 0;
  var text = "Home Page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text),),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              n++;
              text= "Home";
            });
          },
          child: Text("Angka : ${n}"),
        ),
      ),
    );
  }
}