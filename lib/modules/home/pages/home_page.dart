import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:materi/component/text_form_component.dart';
import 'package:materi/modules/home/data/home_account_service.dart';
import 'package:materi/utils/key_list.dart';
import 'package:materi/utils/message.dart';
import 'package:materi/utils/secure_storage_utils.dart';
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

    username = await storage!.read(key: SP_USERNAME);
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
                  builder: (context) =>
                      dialogBuilder(context, username, name, email),
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

  Widget dialogBuilder(BuildContext context, username, name, email) {
    var usernameController = TextEditingController(text: username);
    var nameController = TextEditingController(text: name);
    var emailController = TextEditingController(text: email);
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
              SizedBox(height: 10),
              TextFormComponent(
                Icons.account_box,
                "Nama Anda",
                "Name",
                false,
                nameController,
                TextInputType.name,
              ),
              SizedBox(height: 10),
              TextFormComponent(
                Icons.email,
                "Email Anda",
                "Email",
                false,
                emailController,
                TextInputType.name,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Save")),
        ],
      ),
    );
  }

  _actionUpdateAccount(username, name, email) async {
    var result = await actionUpdateAccountService(username, name, email);
    if (result == null) {
      Message.errorMessage(context, "Update Account");
    } else {
      Message.successMessage(context, "Berhasil Update Account");
      await SecureStorageUtils.saveData(key: SP_USERNAME, value: username);
      await SecureStorageUtils.saveData(key: SP_NAME, value: name);
      await SecureStorageUtils.saveData(key: SP_EMAIL, value: email);
      setState(() {
        this.username = username;
        this.email = email;
        this.name = name;
      });
    }
  }
}
