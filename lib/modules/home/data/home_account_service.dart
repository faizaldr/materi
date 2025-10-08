import 'package:http/http.dart' as http;
import 'package:materi/modules/login/models/login_model.dart';
import 'package:materi/utils/url_list.dart';

Future<User?> actionUpdateAccount(
  String? username,
  String? name,
  String? email,
) async {
  final User user = User(username: username, name: name, email: email);
  final body = user.toJson();
  final response = await http.put(Uri.parse(UPDATE_ACCOUNT_URL), body: body);
  
}
