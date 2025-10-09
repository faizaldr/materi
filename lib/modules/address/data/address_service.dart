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
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final data = AddressModel.fromJson(jsonData);
    return data;
  }
  return null;
}
