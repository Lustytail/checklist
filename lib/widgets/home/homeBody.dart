import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wyeta/hive/home.dart';
import 'package:wyeta/hive/homeList.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wyeta/widgets/home/homState.dart';

class HomeBody extends StatefulWidget {
  Home home; // home class
  final Function onDelete;

  HomeBody({
    super.key,
    required this.home,
    required this.onDelete,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var homeListBox = Hive.box<HomeList>('homeList');
  var homeBox = Hive.box<Home>('home');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "formattedDate",
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Text("[예시]재건축 앞둔 우성아파트"),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Text("전세 7억"),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Row(
                      children: [
                        Text(
                          '\u{1F60D}',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '\u{1F60A}',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '\u{1F614}',
                          style: TextStyle(
                            color: Color.fromARGB(255, 24, 15, 15),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      color: Colors.white,
                      child: Image.memory(
                        widget.home.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                strutStyle: const StrutStyle(fontSize: 8.0),
                text: TextSpan(
                    text: widget.home.description,
                    style: const TextStyle(
                        color: Colors.black,
                        height: 1.4,
                        fontSize: 16.0,
                        fontFamily: 'NanumSquareRegular')),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      5.0), // Adjust the radius for rounded corners
                  side: const BorderSide(
                      color: Colors.black), // Border color to black
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              minimumSize: MaterialStateProperty.all(
                const Size(double.infinity, 40),
              ),
            ),
            onPressed: () {
              //콜백함수
              // widget.onDelete(widget.home);

              context.read<HomeState>().deleteHome(widget.home);
            },
            child: const Text("예시 삭제하기"),
          ),
        ),
      ],
    );
  }
}
