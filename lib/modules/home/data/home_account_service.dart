import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:materi/modules/login/models/login_model.dart';
import 'package:materi/utils/key_list.dart';
import 'package:materi/utils/url_list.dart';
import 'package:materi/utils/secure_storage_utils.dart';

Future<User?> actionUpdateAccount(
  String? username,
  String? name,
  String? email,
) async {
  final User user = User(username: username, name: name, email: email);
  final body = user.toJson();
  final token = await SecureStorageUtils.readData(key: SP_TOKEN);
  final headers = {'authorization': 'Bearer $token'};
  final response = await http.put(
    Uri.parse(UPDATE_ACCOUNT_URL),
    headers: headers,
    body: body,
  );
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final userModel = User.fromJson(jsonData);
    return userModel;
  } else {
    return null;
  }
}
