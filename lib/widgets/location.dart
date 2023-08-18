import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key, required this.title});

  final String title;

  @override
  State<MyLocation> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyLocation> {
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
            const Text('   '),
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
