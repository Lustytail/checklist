import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GPSWidget extends StatefulWidget {
  const GPSWidget({super.key});

  @override
  State<GPSWidget> createState() => _GPSWidgetState();
}

class _GPSWidgetState extends State<GPSWidget> {
  double _latitude = 0;
  double _longitude = 0;

  Future<void> myLocate() async {
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '위도 : ${_latitude.toStringAsFixed(4)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            '경도 : ${_longitude.toStringAsFixed(4)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          ElevatedButton(
            onPressed: myLocate,
            child: const Text(
              'Click',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
