import 'package:flutter/material.dart';
import 'package:materi/modules/login/pages/login_page.dart';
import 'package:materi/utils/secure_storage_utils.dart';

bool isLogin = false;
Future<void> main() async {
  SecureStorageUtils.readData(key: key, value: value)
  var app = App();
  runApp(app);
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}
