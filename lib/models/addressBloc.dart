import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wyeta/models/address.dart';
import 'package:wyeta/models/addressFactory.dart';
import 'package:wyeta/models/errorModel.dart';

class AddressBloc {
  static final apiKey = dotenv.get("API_KEY");
  final AddressFactory _addressFactory = AddressFactory();

  final _addressFetcher = PublishSubject<List<Juso>>();
  Stream<List<Juso>> get address => _addressFetcher.stream;
  final List<Juso> _addressList = [];

  dispose() {
    _addressFetcher.close();
  }

  void fetchAddress(String keyword, int pageNumber) async {
    String query = "";
    query = httpGetQuery(query, "confmKey", apiKey);
    query = httpGetQuery(query, "currentPage", '$pageNumber');
    query = httpGetQuery(query, "countPerPage", '10');
    query = httpGetQuery(query, "keyword", keyword);
    query = httpGetQuery(query, "resultType", 'json');
    print(query);

    try {
      Address address = await _addressFactory.searchAddress(query);

      if (address.jusoList.isEmpty && address.common.errorCode == '0') {
        throw ErrorModel(statusCode: 0, error: -101, message: '검색 결과가 없습니다.');
      } else if (address.common.errorCode != '0') {
        throw ErrorModel(
            statusCode: 0, error: 0, message: address.common.errorMessage);
      }

      if (pageNumber == 1) _addressList.clear();
      _addressList.addAll(address.jusoList);
      _addressFetcher.sink.add(_addressList);
    } catch (e) {
      _addressFetcher.sink.addError(e);
    }
  }

  String httpGetQuery(String query, String key, String value) {
    if (value == null) {
      return query;
    }
    String firstWord = query == "" ? "?" : "$query&";
    return "$firstWord$key=$value";
  }
}
