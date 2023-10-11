import 'dart:convert';

import 'package:http/http.dart';
import 'package:wyeta/models/address.dart';

class AddressFactory {
  Future<Address> searchAddress(String query) async {
    String temp = "https://business.juso.go.kr/addrlink/addrLinkApi.do$query";

    Uri url = Uri.parse(temp);

    Response response = await get(url);
    String bodyString = utf8.decode(response.bodyBytes);
    Map<String, dynamic> body = jsonDecode(bodyString);

    return Address.formJson(body);
  }
}
