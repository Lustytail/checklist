import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'I Wanna Know My Location'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _latitude = 0;
  double _longitude = 0;


  Future<void> _myGPS() async {

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {



    Future<Position> getCurrentLocation() async {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
    }

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'My Location',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text('   '),
            Text(
              '위도 : $_latitude',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              '경도 : $_longitude',
              style: Theme.of(context).textTheme.headlineSmall,
            ), 
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _myGPS,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
