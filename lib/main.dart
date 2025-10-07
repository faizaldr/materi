import 'package:flutter/material.dart';
import 'package:materi/modules/home/page/home_page.dart';
import 'package:materi/modules/login/pages/login_page.dart';
import 'package:materi/utils/key_list.dart';
import 'package:materi/utils/secure_storage_utils.dart';

bool isLogin = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecureStorageUtils.readData(key: SP_TOKEN) != null
      ? isLogin = true
      : isLogin = false;
  var app = App();
  runApp(app);
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: isLogin ? HomePage() : LoginPage());
  }
}
