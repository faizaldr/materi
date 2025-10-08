import 'package:flutter/material.dart';
import 'package:materi/component/text_form_component.dart';
import 'package:materi/modules/home/pages/home_page.dart';
import 'package:materi/modules/login/data/login_service.dart';
import 'package:materi/utils/message.dart';
import 'package:materi/utils/key_list.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  FlutterSecureStorage? storage;

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  IOSOptions _getIosOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  @override
  void initState() {
    super.initState();
    initFlutterSecureStorage();
  }

  void initFlutterSecureStorage() async {
    storage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIosOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://media.istockphoto.com/id/656453072/photo/vintage-retro-grungy-background-design-and-pattern-texture.jpg?s=612x612&w=0&k=20&c=PiX0bt3N6Hqk7yO7g52FWCunpjqm_9LhjRA2gkbl5z8=",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Image.asset(
                    "assets/images/logo.webp",
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 100),
                  TextFormComponent(
                    Icons.mail,
                    "Nama akun anda",
                    "Username",
                    false,
                    username,
                    TextInputType.text,
                    validator: _usernameValidation,
                  ),
                  const SizedBox(height: 20),
                  TextFormComponent(
                    Icons.key,
                    "Password Anda",
                    "Password",
                    true,
                    password,
                    TextInputType.text,
                    prefixIcon2: Icons.key_off,
                    validator: _passwordValidation,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _actionLogin();
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _actionLogin() async {
    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      var result = await actionLoginService(username.text, password.text);
      if (result == null) {
        Message.errorMessage(context, "Gagal Login");
      } else {
        Message.successMessage(context, "Berhasil Login");
        await storage!.write(key: SP_TOKEN, value: result.jwt!);
        await storage!.write(key: SP_USERNAME, value: result.user!.username);
        await storage!.write(key: SP_NAME, value: result.user!.name);
        await storage!.write(key: SP_EMAIL, value: result.user!.email);
        await storage!.write(key: SP_BIRTH_DATE, value: result.user!.birthDate);

        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => HomePage()));
      }
    } else {
      Message.errorMessage(context, "Data tidak sesuai!");
    }
  }

  String? _usernameValidation(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return "Username tidak boleh kurang dari 3 karakter";
    }
    return null;
  }

  String? _passwordValidation(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return "Password tidak boleh kurang dari 3 karakter";
    }
    return null;
  }
}
