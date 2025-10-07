import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:materi/modules/login/models/login_model.dart';
import 'package:materi/modules/login/models/request_login_model.dart';
import 'package:materi/utils/url_list.dart';

Future<LoginModel?> actionLoginService(
  String identifier,
  String password,
) async {
  final requestLoginModel = RequestLoginModel(
    identifier: identifier,
    password: password,
  );
  final body = requestLoginModel.toJson();
  final response = await http.post(Uri.parse(LOGIN_URL), body: body);
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final loginModel = LoginModel.fromJson(jsonData);
    return loginModel;
  } else {
    return null;
  }
}
