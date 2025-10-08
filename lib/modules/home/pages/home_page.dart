import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:materi/component/text_form_component.dart';
import 'package:materi/modules/home/data/home_account_service.dart';
import 'package:materi/modules/login/pages/login_page.dart';
import 'package:materi/utils/key_list.dart';
import 'package:materi/utils/message.dart';
import 'package:materi/utils/secure_storage_utils.dart';
import 'package:materi/utils/text_formatter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
      appBar: AppBar(
        title: Text(text),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                suffixIcon: IconButton(icon: Icon(Icons.mic), onPressed: () {}),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hint: Text("Search"),
              ),
            ),
            SizedBox(height: 20),
            _listViewPromo(context),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Text("Category")),
                Expanded(child: Text("Show All", textAlign: TextAlign.right)),
              ],
            ),
            _listViewCategory(context),
            SizedBox(height: 20),
            Text("Most Popular 🔥"),
            _gridViewPopular(context),
          ],
        ),
      ),
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
              onTap: () {
                _actionLogOut(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  _listViewPromo(context) {
    var url = [
      "https://d12grbvu52tm8q.cloudfront.net/AHI/Compro/d83d7fd4-61ea-46b3-81ff-e0692e126271.jpg",
      "https://www.bankbsi.co.id/storage/promos/rc7Ijih94cMSRq2WewhFnPdE5AFZBE6Lm1fImvIy.jpg",
      "https://news.codashop.com/id/wp-content/uploads/sites/4/2022/04/Telkomsel-Bonus-Kuota-Banner-696x267.jpg",
    ];
    CarouselOptions options = CarouselOptions(
      autoPlay: true,
      autoPlayAnimationDuration: Duration(seconds: 1),
    );
    return SizedBox(
      height: 200,
      child: CarouselSlider(
        options: options,
        items: url
            .map(
              (i) => Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(color: Colors.white),
                child: CachedNetworkImage(
                  imageUrl: i,
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ), //i sebagai value
              ),
            )
            .toList(),
      ),
    );
  }

  _listViewCategory(context) {
    List<Map<String, dynamic>> item = [
      {"icon": Icons.account_balance_wallet_rounded, "text": "Kampus"},
      {"icon": Icons.account_balance_wallet_rounded, "text": "Kampus"},
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: item.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [Icon(item[index]["icon"]), Text(item[index]["text"])],
          ),
        ),
      ),
    );
  }

  _gridViewPopular(context) {
    List<Map<String, dynamic>> item = [
      {
        "url":
            "https://scontent.fjog3-1.fna.fbcdn.net/v/t39.30808-6/462513075_2723923894445597_2986586797287622815_n.png?stp=dst-png_p526x296&_nc_cat=107&ccb=1-7&_nc_sid=0b6b33&_nc_ohc=gNPitVmxttkQ7kNvwEH8m6-&_nc_oc=AdlDU8VtuAll0v-p-ouLEPN7Et99tbeP2Tsdfz39SRrZOG0hFkN8T9q-4aHcFUFxvd4&_nc_zt=23&_nc_ht=scontent.fjog3-1.fna&_nc_gid=X_s2NVqLDINaNLR_QZHYRw&oh=00_Aff0tLHDCXIQ6tu95g677zicW0xwukMcDXqiIF31TuLJog&oe=68EBD05A",
        "text": "Air Minum 600 ml",
      },
      {
        "url":
            "https://scontent.fjog3-1.fna.fbcdn.net/v/t39.30808-6/462513075_2723923894445597_2986586797287622815_n.png?stp=dst-png_p526x296&_nc_cat=107&ccb=1-7&_nc_sid=0b6b33&_nc_ohc=gNPitVmxttkQ7kNvwEH8m6-&_nc_oc=AdlDU8VtuAll0v-p-ouLEPN7Et99tbeP2Tsdfz39SRrZOG0hFkN8T9q-4aHcFUFxvd4&_nc_zt=23&_nc_ht=scontent.fjog3-1.fna&_nc_gid=X_s2NVqLDINaNLR_QZHYRw&oh=00_Aff0tLHDCXIQ6tu95g677zicW0xwukMcDXqiIF31TuLJog&oe=68EBD05A",
        "text": "Air Minum 300 ml",
      },
      {
        "url":
            "https://scontent.fjog3-1.fna.fbcdn.net/v/t39.30808-6/462513075_2723923894445597_2986586797287622815_n.png?stp=dst-png_p526x296&_nc_cat=107&ccb=1-7&_nc_sid=0b6b33&_nc_ohc=gNPitVmxttkQ7kNvwEH8m6-&_nc_oc=AdlDU8VtuAll0v-p-ouLEPN7Et99tbeP2Tsdfz39SRrZOG0hFkN8T9q-4aHcFUFxvd4&_nc_zt=23&_nc_ht=scontent.fjog3-1.fna&_nc_gid=X_s2NVqLDINaNLR_QZHYRw&oh=00_Aff0tLHDCXIQ6tu95g677zicW0xwukMcDXqiIF31TuLJog&oe=68EBD05A",
        "text": "Air Minum 300 ml",
      },
      {
        "url":
            "https://scontent.fjog3-1.fna.fbcdn.net/v/t39.30808-6/462513075_2723923894445597_2986586797287622815_n.png?stp=dst-png_p526x296&_nc_cat=107&ccb=1-7&_nc_sid=0b6b33&_nc_ohc=gNPitVmxttkQ7kNvwEH8m6-&_nc_oc=AdlDU8VtuAll0v-p-ouLEPN7Et99tbeP2Tsdfz39SRrZOG0hFkN8T9q-4aHcFUFxvd4&_nc_zt=23&_nc_ht=scontent.fjog3-1.fna&_nc_gid=X_s2NVqLDINaNLR_QZHYRw&oh=00_Aff0tLHDCXIQ6tu95g677zicW0xwukMcDXqiIF31TuLJog&oe=68EBD05A",
        "text": "Air Minum 300 ml",
      },
    ];

    var gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );

    return SizedBox(
      height: 500,
      child: GridView.builder(
        itemCount: item.length,
        gridDelegate: gridDelegate,
        itemBuilder: (context, index) => Card(
          elevation: 4, //shadow effect
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: CachedNetworkImage(imageUrl: item[index]["url"])),
              SizedBox(height: 8),
              Container(
                height: 20,
                child: Text(
                  item[index]["text"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var _pageIndex = 0;
  _bottomNavigationBar() {
    List<Map<String, dynamic>> item = [
      {"icon": Icons.home, "text": "Home"},
      {"icon": Icons.info, "text": "About"},
      {"icon": Icons.warning, "text": "Warning"},
      {"icon": Icons.dangerous, "text": "Dangerous"},
    ];
    // BottomNavigationBar 2 s/d 4
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      currentIndex: _pageIndex,
      onTap: _changePage,
      items: item
          .map(
            (i) => BottomNavigationBarItem(
              icon: Icon(i["icon"]),
              label: i["text"],
            ),
          )
          .toList(),
    );
  }

  _changePage(value) {
    setState(() {
      _pageIndex = value;
    });
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
          ElevatedButton(
            onPressed: () {
              _actionUpdateAccount(
                usernameController.text,
                nameController.text,
                emailController.text,
              );
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  _actionUpdateAccount(username, name, email) async {
    var result = await actionUpdateAccountService(username, name, email);
    if (result == null) {
      // Message.errorMessage(context, "Gagal Update Account");
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: "Gagal Update Account"),
      );
    } else {
      // Message.successMessage(context, "Berhasil Update Account");
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(message: "Berhasil Update Account"),
      );
      await SecureStorageUtils.saveData(key: SP_USERNAME, value: username);
      await SecureStorageUtils.saveData(key: SP_NAME, value: name);
      await SecureStorageUtils.saveData(key: SP_EMAIL, value: email);
      setState(() {
        this.username = username;
        this.email = email;
        this.name = name;
      });
      Navigator.of(context).pop();
    }
  }

  _actionLogOut(context) async {
    await SecureStorageUtils.deleteAllData();
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => LoginPage()));
    Message.successMessage(context, "Selamat Datang Kembali");
  }
}
