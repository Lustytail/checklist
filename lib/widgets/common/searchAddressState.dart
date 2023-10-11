import 'package:flutter/material.dart';
import 'package:wyeta/models/addressBloc.dart';
import 'package:wyeta/models/errorModel.dart';

import '../../models/address.dart';

class SearchAddressState extends StatefulWidget {
  const SearchAddressState({super.key});
  // static const String routeName = '/navigator/address_search';

  @override
  State<SearchAddressState> createState() => _SearchAddressStateState();
}

class _SearchAddressStateState extends State<SearchAddressState> {
  final searchTec = TextEditingController();
  final scrollController = ScrollController();
  final addressBloc = AddressBloc();
  List<Juso> addressList = [];
  String keyword = "검색어를 입력하세요.";
  String errorMessage = "";
  late int page;

  @override
  void initState() {
    super.initState();
    addAddressStreamListener();
    addScrollListener();
    addTextEditListener();
  }

  addAddressStreamListener() {
    addressBloc.address.listen(
      (list) {
        addressList = list;
        setState(() {});
      },
      onError: (error, stacktrace) {
        print("onError: $error");
        print(stacktrace.toString());

        if (error is ErrorModel == false) return;

        ErrorModel errorModel = error;
        if (page == 1) addressList = [];
        if (errorModel.error == -101) page = -1;

        errorMessage = errorModel.message;
        setState(() {});
      },
    );
  }

  addScrollListener() {
    scrollController.addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  addTextEditListener() {
    searchTec.addListener(() async {
      if (keyword == searchTec.text) return;
      keyword = searchTec.text;
      page = 1;
      addressBloc.fetchAddress(keyword, page);
    });
  }

  @override
  void dispose() {
    addressBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              const Column(
                children: [
                  Text("주소 검색", style: TextStyle(fontSize: 50)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: searchTextField()),
                  cancelWidget(),
                  const SizedBox(width: 10)
                ],
              ),
              Expanded(child: listView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchTextField() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 50,
      alignment: Alignment.center,
      child: TextField(
        controller: searchTec,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "주소 입력",
          hintStyle: TextStyle(color: Color(0xFFA0A0A0)),
        ),
      ),
    );
  }

  Widget cancelWidget() {
    if (keyword.isEmpty) return Container();

    return GestureDetector(
      child: const Icon(
        Icons.cancel,
        color: Color(0xFFBFBFBF),
        size: 20,
      ),
      onTap: () => searchTec.clear(),
    );
  }

  Widget listView() {
    if (addressList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 15,
              color: const Color(0xFFEdEdEd),
            ),
            Expanded(
                child: Center(
              child: Text(errorMessage),
            ))
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: addressList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Container(height: 15, color: const Color(0xFFEdEdEd));
        }
        if (index == addressList.length) addAddressList();

        final address = addressList[index - 1];
        return Column(
          children: [
            listItem(address),
            Container(height: 1, color: const Color(0xFFEdEdEd)),
          ],
        );
      },
    );
  }

  Widget listItem(Juso address) {
    final roadLast = address.buldSlno == '0' ? '' : '-${address.buldSlno}';
    final rodaTitle = '${address.rn} ${address.buldMnnm}$roadLast';
    final title = address.bdNm.isEmpty ? rodaTitle : address.bdNm;

    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Map<String, String> addressMap = {
            "jibunAddr": address.jibunAddr,
            "roadAddr": address.roadAddr,
          };
          print(addressMap['jibunAddr']);
          Navigator.pop(context, addressMap);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              address.jibunAddr,
              style: const TextStyle(color: Color(0xFFA8A8A8)),
            ),
            Text(
              '[도로명] ${address.roadAddr}',
              style: const TextStyle(color: Color(0xFFA8A8A8)),
            ),
          ],
        ),
      ),
    );
  }

  addAddressList() {
    if (page == -1) return;
    ++page;
    addressBloc.fetchAddress(keyword, page);
  }
}
