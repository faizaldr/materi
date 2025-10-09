import 'dart:convert';

import 'package:materi/modules/address/models/address_model.dart';
import 'package:http/http.dart' as http;
import 'package:materi/utils/key_list.dart';
import 'package:materi/utils/secure_storage_utils.dart';
import 'package:materi/utils/url_list.dart';

Future<AddressModel?> actionGetAddressService(int indexPage) async {
  final paginationSize = 2;
  final urlParams =
      "?pagination[page]=${indexPage}&pagination[pageSize]=${paginationSize}";
  final token = await SecureStorageUtils.readData(key: SP_TOKEN);
  final headers = {'Authorization': 'Bearer ${token}'};
  final response = await http.get(
    Uri.parse(ADDRESS_URL + urlParams),
    headers: headers,
  );
  // print(response.body);
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final data = AddressModel.fromJson(jsonData);
    return data;
  }
  return null;
}

Future<bool> actionSaveAddressService(
  Data parseData, {
  bool isInsert = true,
}) async {
  final token = await SecureStorageUtils.readData(key: SP_TOKEN);
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  http.Response response;

  if (isInsert) {
    response = await http.post(
      Uri.parse(ADDRESS_URL),
      headers: headers,
      body: jsonEncode({'data': parseData.toJson()}),
    );
    print(response.body);
    return response.statusCode == 200 || response.statusCode == 201;
  } else {
    if (parseData.id == null) return false;
    response = await http.put(
      Uri.parse('$ADDRESS_URL/${parseData.documentId}'),
      headers: headers,
      body: jsonEncode({'data': parseData.toJson()}),
    );
    print(response.body);
    return response.statusCode == 200;
  }
}

Future<bool> actionDeleteAddressService(String documentId) async {
  print(documentId);
  final token = await SecureStorageUtils.readData(key: SP_TOKEN);
  final headers = {
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  };

  http.Response response;

  if (documentId == null) return false;
  response = await http.delete(
    Uri.parse('$ADDRESS_URL/${documentId}'),
    headers: headers,
  );

  return response.statusCode == 200 || response.statusCode == 204;
}
