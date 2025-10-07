import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:materi/component/text_form_component.dart';
import 'package:materi/utils/key_list.dart';
import 'package:materi/utils/text_formatter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var text = "Home Page";
  var username;
  var name;
  var email;
  var birthDate;
  FlutterSecureStorage? storage;

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  IOSOptions _getIosOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  @override
  void initState() {
    super.initState();
    initDrawer();
  }

  void initDrawer() async {
    storage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );

    username = await storage!.read(key: SP_TOKEN);
    name = await storage!.read(key: SP_NAME);
    email = await storage!.read(key: SP_EMAIL);
    birthDate = await storage!.read(key: SP_BIRTH_DATE);

    setState(() {
      username = username;
      name = name;
      email = email;
      birthDate = birthDate;
    });
    debugPrint(username);
    debugPrint(name);
    debugPrint(email);
    debugPrint(birthDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text)),
      body: Center(),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name ?? "-"),
              accountEmail: Text(email ?? "-"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  getInitialText(name ?? "-"),
                  style: TextStyle(fontSize: 24),
                ),
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
              leading: Icon(Icons.settings),
              title: Text("CHANGE ACCOUNT"),
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => dialogBuilder(context),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("LOGOUT"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogBuilder(BuildContext context) {
    var usernameController = TextEditingController();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    return IntrinsicHeight(
      child: AlertDialog(
        title: Text("Change Account"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormComponent(
                Icons.man,
                "Nama Pengguna Anda",
                "Username",
                false,
                usernameController,
                TextInputType.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
