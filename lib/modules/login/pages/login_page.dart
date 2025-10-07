import 'package:flutter/material.dart';

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
            child: ListView(
              children: [
                Image.asset("assets/images/logo.webp", width: 120, height: 120),
                Text(
                  "SISTER for STUDENT\nNEXT-GEN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
                    hintText: "Username",
                    labelText: "Username",
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
                    hintText: "Kata sandi",
                    labelText: "Password",
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
