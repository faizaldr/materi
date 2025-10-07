import 'package:flutter/material.dart';
import 'package:materi/component/text_form_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://media.istockphoto.com/id/656453072/photo/vintage-retro-grungy-background-design-and-pattern-texture.jpg?s=612x612&w=0&k=20&c=PiX0bt3N6Hqk7yO7g52FWCunpjqm_9LhjRA2gkbl5z8=",
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: [
                  Image.asset(
                    "assets/images/logo.webp",
                    width: 120,
                    height: 120,
                  ),
                  Text(
                    "SISTER for STUDENT\nNEXT-GEN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 100),
                  TextFormComponent(
                    Icons.mail,
                    "Nama akun anda",
                    "Username",
                    false,
                    username,
                    TextInputType.text,
                    validator: _usernameValidataion,
                  ),
                  SizedBox(height: 20),
                  TextFormComponent(
                    Icons.key,
                    "Password Anda",
                    "Password",
                    true,
                    password,
                    TextInputType.text,
                    prefixIcon2: Icons.key_off,
                    validator: _passwordValidataion,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _actionLogin(context);
                    },
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _usernameValidataion(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return "Username tidak boleh kurang dari 3 karakter";
    }
    return null;
  }

  String? _passwordValidataion(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return "Password tidak boleh kurang dari 3 karakter";
    }
    return null;
  }

  /*void*/
  _actionLogin(context) {
    if (Form.of(context)?.validate() ?? false) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Data tidak sesuai")));
    }
  }
}
