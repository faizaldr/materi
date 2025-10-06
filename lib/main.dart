import 'package:flutter/material.dart';
import 'package:materi/modules/login/pages/login_page.dart';

void main() {
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

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _HomePageState();
//   }
// }

// class _HomePageState extends State<HomePage> {
//   var n = 0;
//   var text = "Home Page";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(text)),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             setState(() {
//               n++;
//               text = "Home";
//             });
//           },
//           child: Text("Angka : ${n}"),
//         ),
//       ),
//     );
//   }
// }
