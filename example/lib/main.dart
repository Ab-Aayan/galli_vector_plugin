import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:galli_vector_plugin/galli_vector_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VectorMap(),
    );
  }
}

class VectorMap extends StatefulWidget {
  const VectorMap({super.key});

  @override
  State<VectorMap> createState() => _VectorMapState();
}

class _VectorMapState extends State<VectorMap> {
  GalliMapController? controller;
  GalliMethods methods = GalliMethods("token");
  List<Marker> markers = [];
  late void Function() clearMarkers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GalliMap(
            showCurrentLocation: true,
            authToken: "token",
            size: (
              height: MediaQuery.of(context).size.height * 2,
              width: MediaQuery.of(context).size.width * 2,
            ),
            compassPosition: (
              position: CompassViewPosition.topRight,
              offset: const Point(32, 82)
            ),
            showCompass: true,
            onMapCreated: (newC) {
              controller = newC;

              controller!.addFill(FillOptions());
              controller!.addCircle(CircleOptions(
                circleOpacity: 0.32,
                geometry: LatLng(27.677670698052346, 85.32128605620954),
                circleRadius: 50,
              ));
              setState(() {});
            },
            onMapClick: (LatLng latLng) {
              // methods.get360Image(latLng).then((value) {
              //   if (value != null) {
              //     GalliViewer galliViewer = GalliViewer(
              //       builder:
              //           (BuildContext context, Function() methodFromChild) {
              //         clearMarkers = methodFromChild;
              //       },
              //       image: value,
              //       onTap: (latitude, longitude, tilt) {},
              //       markers: markers,
              //       maxMarkers: 2,
              //     );
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (_) => Scaffold(
              //                 appBar: AppBar(
              //                   actions: [
              //                     GestureDetector(
              //                         onTap: () {
              //                           clearMarkers();
              //                         },
              //                         child: const Text("Clear"))
              //                   ],
              //                 ),
              //                 body: galliViewer)));
              //   } else {
              //     log("Image not found");
              //   }
              // });

              // String? data =
              //     await galliMapController!.reverGeoCoding(latLng);
              log("latlng $latLng");
            },
          ),
        ),
      ),
    );
  }
}
