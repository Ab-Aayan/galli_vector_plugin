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
      home: const NewMainMap(),
    );
  }
}

class NewMainMap extends StatefulWidget {
  const NewMainMap({super.key});

  @override
  State<NewMainMap> createState() => _NewMainMapState();
}

class _NewMainMapState extends State<NewMainMap> {
  GalliMapController? controller;
  GalliMethods methods = GalliMethods("89a40903-b75a-46b6-822b-86eebad4fa36");
  List<Marker> markers = [];
  late void Function() clearMarkers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GalliMap(
            authToken: "89a40903-b75a-46b6-822b-86eebad4fa36",
            size: (
              height: MediaQuery.of(context).size.height * 2,
              width: MediaQuery.of(context).size.width * 2,
            ),
            compassPosition: (
              position: CompassViewPosition.TopRight,
              offset: const Point(32, 82)
            ),
            showCompass: true,
            onMapCreated: (newC) {
              controller = newC;
              setState(() {});
            },
            onMapClick: (LatLng latLng) async {
              String image = await methods.get360Image(latLng);
              GalliViewer galliViewer = GalliViewer(
                builder: (BuildContext context, Function() methodFromChild) {
                  clearMarkers = methodFromChild;
                },
                image: image,
                onTap: (latitude, longitude, tilt) {},
                markers: markers,
                maxMarkers: 2,
              );
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => Scaffold(
              //             appBar: AppBar(
              //               actions: [
              //                 GestureDetector(
              //                     onTap: () {
              //                       clearMarkers();
              //                     },
              //                     child: Text("Clear"))
              //               ],
              //             ),
              //             body: galliViewer)));
              // String? data =
              //     await galliMapController!.reverGeoCoding(latLng);
            },
          ),
        ),
      ),
    );
  }
}

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  GalliMapController? controller;
  GalliMethods methods = GalliMethods("89a40903-b75a-46b6-822b-86eebad4fa36");
  List<Marker> markers = [];
  late void Function() clearMarkers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.green),
      backgroundColor: const Color(0xffa262c4),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/material.jpg",
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.difference,
                filterQuality: FilterQuality.high,
                color: const Color(0xffa262c4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff212121), width: 4),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff212121).withOpacity(0.36),
                            blurRadius: 4,
                            offset: const Offset(4, 4),
                            spreadRadius: 4),
                        BoxShadow(
                            color: const Color(0xff212121).withOpacity(0.36),
                            blurRadius: 4,
                            offset: const Offset(-4, -4),
                            spreadRadius: 4)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: GalliMap(
                      authToken: "89a40903-b75a-46b6-822b-86eebad4fa36",
                      size: (
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                      compassPosition: (
                        position: CompassViewPosition.TopRight,
                        offset: const Point(32, 82)
                      ),
                      showCompass: true,
                      onMapCreated: (newC) {
                        controller = newC;
                        setState(() {});
                      },
                      onMapClick: (LatLng latLng) async {
                        String image = await methods.get360Image(latLng);
                        GalliViewer galliViewer = GalliViewer(
                          builder: (BuildContext context,
                              Function() methodFromChild) {
                            clearMarkers = methodFromChild;
                          },
                          image: image,
                          onTap: (latitude, longitude, tilt) {},
                          markers: markers,
                          maxMarkers: 2,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Scaffold(
                                    appBar: AppBar(
                                      actions: [
                                        GestureDetector(
                                            onTap: () {
                                              clearMarkers();
                                            },
                                            child: Text("Clear"))
                                      ],
                                    ),
                                    body: galliViewer)));
                        // String? data =
                        //     await galliMapController!.reverGeoCoding(latLng);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Transform.rotate(
                      angle: -0.45,
                      child: SizedBox(
                        width: 164,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () async {
                                  galliMapController!.show360Lines();
                                },
                                child: Container(
                                  height: 36,
                                  width: 132,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: const Color(0xff212121),
                                          width: 4),
                                      color: const Color(0xff33d48a),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xff212121)
                                                .withOpacity(0.32),
                                            blurRadius: 2,
                                            offset: const Offset(2, 2),
                                            spreadRadius: 2),
                                        BoxShadow(
                                            color: const Color(0xff212121)
                                                .withOpacity(0.32),
                                            blurRadius: 2,
                                            offset: const Offset(-2, -2),
                                            spreadRadius: 2)
                                      ]),
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: SizedBox(
                                        height: 36,
                                        width: 132,
                                        child: Image.asset(
                                          "assets/material.jpg",
                                          fit: BoxFit.cover,
                                          colorBlendMode: BlendMode.difference,
                                          color: const Color(0xff33d48a),
                                        ),
                                      ),
                                    ),
                                    const Center(
                                      child: Text(
                                        "MODE",
                                        style: TextStyle(
                                            color: Color(0xff212121),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  // LatLng? myLocation =
                                  //     await controller!.requestMyLocationLatLng();
                                  // controller!.animateCamera(CameraUpdate.newLatLng(myLocation!),
                                  //     duration: const Duration(milliseconds: 500));
                                  // controller!
                                  //     .moveCamera(CameraUpdate.newLatLngZoom(myLocation, 18));
                                  // controller!.moveCamera(CameraUpdate.newCameraPosition(
                                  //     CameraPosition(
                                  //         target: myLocation, bearing: 40, tilt: 30, zoom: 12)));
                                  // controller!.animateCamera(
                                  //     CameraUpdate.bearingTo(0.0)); //animates to north
                                  // controller!.animateCamera(CameraUpdate.tiltTo(60)); // 3d view
                                  var symbol = await controller!
                                      .addGalliMarker(const GalliMarkerOptions(
                                    iconImage: "assets/location_marker.png",
                                    geometry: LatLng(27.701233, 85.295926),
                                  ));
                                  controller!.animateCamera(
                                      CameraUpdate.newLatLng(
                                          const LatLng(27.701233, 85.295926)),
                                      duration:
                                          const Duration(milliseconds: 500));
                                  await Future.delayed(
                                      const Duration(milliseconds: 10000));
                                  controller!.removeGalliMarker(symbol);
                                },
                                child: Container(
                                  height: 36,
                                  width: 132,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: const Color(0xff212121),
                                          width: 4),
                                      color: const Color(0xff33d48a),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xff212121)
                                                .withOpacity(0.32),
                                            blurRadius: 2,
                                            offset: const Offset(2, 2),
                                            spreadRadius: 2),
                                        BoxShadow(
                                            color: const Color(0xff212121)
                                                .withOpacity(0.32),
                                            blurRadius: 2,
                                            offset: const Offset(-2, -2),
                                            spreadRadius: 2)
                                      ]),
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: SizedBox(
                                        height: 36,
                                        width: 132,
                                        child: Image.asset(
                                          "assets/material.jpg",
                                          fit: BoxFit.cover,
                                          colorBlendMode: BlendMode.difference,
                                          color: const Color(0xff33d48a),
                                        ),
                                      ),
                                    ),
                                    const Center(
                                      child: Text(
                                        "CLEAR",
                                        style: TextStyle(
                                            color: Color(0xff212121),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(),
                    Transform.rotate(
                      angle: 0.83,
                      child: SizedBox(
                        width: 108,
                        height: 108,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.spaceBetween,
                          children: [
                            Transform.rotate(
                              angle: -0.83,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xffe24167),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0xff212121)
                                              .withOpacity(0.32),
                                          blurRadius: 2,
                                          offset: const Offset(2, 2),
                                          spreadRadius: 2),
                                      BoxShadow(
                                          color: const Color(0xff212121)
                                              .withOpacity(0.32),
                                          blurRadius: 2,
                                          offset: const Offset(-2, -2),
                                          spreadRadius: 2)
                                    ],
                                    border: Border.all(
                                        width: 4,
                                        color: const Color(0xff212121))),
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: SizedBox(
                                      height: 48,
                                      width: 48,
                                      child: Image.asset(
                                        "assets/material.jpg",
                                        fit: BoxFit.cover,
                                        colorBlendMode: BlendMode.difference,
                                        color: const Color(0xffe24167),
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "M",
                                      style: TextStyle(
                                          color: Color(0xff212121),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Transform.rotate(
                              angle: -0.83,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xffe24167),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0xff212121)
                                              .withOpacity(0.32),
                                          blurRadius: 2,
                                          offset: const Offset(2, 2),
                                          spreadRadius: 2),
                                      BoxShadow(
                                          color: const Color(0xff212121)
                                              .withOpacity(0.32),
                                          blurRadius: 2,
                                          offset: const Offset(-2, -2),
                                          spreadRadius: 2)
                                    ],
                                    border: Border.all(
                                        width: 4,
                                        color: const Color(0xff212121))),
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: SizedBox(
                                      height: 48,
                                      width: 48,
                                      child: Image.asset(
                                        "assets/material.jpg",
                                        fit: BoxFit.cover,
                                        colorBlendMode: BlendMode.difference,
                                        color: const Color(0xffe24167),
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "L",
                                      style: TextStyle(
                                          color: Color(0xff212121),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Transform.rotate(
                              angle: -0.83,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xffe24167),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0xff212121)
                                              .withOpacity(0.32),
                                          blurRadius: 2,
                                          offset: const Offset(2, 2),
                                          spreadRadius: 2),
                                      BoxShadow(
                                          color: const Color(0xff212121)
                                              .withOpacity(0.32),
                                          blurRadius: 2,
                                          offset: const Offset(-2, -2),
                                          spreadRadius: 2)
                                    ],
                                    border: Border.all(
                                        width: 4,
                                        color: const Color(0xff212121))),
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: SizedBox(
                                      height: 48,
                                      width: 48,
                                      child: Image.asset(
                                        "assets/material.jpg",
                                        fit: BoxFit.cover,
                                        colorBlendMode: BlendMode.difference,
                                        color: const Color(0xffe24167),
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "P",
                                      style: TextStyle(
                                          color: Color(0xff212121),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Transform.rotate(
                              angle: -0.83,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0xff212121)
                                              .withOpacity(0.32),
                                          blurRadius: 2,
                                          offset: const Offset(2, 2),
                                          spreadRadius: 2),
                                      BoxShadow(
                                          color: const Color(0xff212121)
                                              .withOpacity(0.32),
                                          blurRadius: 2,
                                          offset: const Offset(-2, -2),
                                          spreadRadius: 2)
                                    ],
                                    color: const Color(0xffe24167),
                                    border: Border.all(
                                        width: 4,
                                        color: const Color(0xff212121))),
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: SizedBox(
                                      height: 48,
                                      width: 48,
                                      child: Image.asset(
                                        "assets/material.jpg",
                                        fit: BoxFit.cover,
                                        colorBlendMode: BlendMode.difference,
                                        color: const Color(0xffe24167),
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "C",
                                      style: TextStyle(
                                          color: Color(0xff212121),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
