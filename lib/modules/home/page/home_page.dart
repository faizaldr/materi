import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var text = "Home Page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text)),
      body: Center(),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("contoh"),
              accountEmail: Text("email"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("F", style: TextStyle(fontSize: 24)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("HOME"),
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => HomePage())),
            ),
             ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("LOGOUT"),
              onTap: (){}
            ),
          ],
        ),
      ),
    );
  }
}
