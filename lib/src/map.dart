import 'dart:math' hide log;
import 'package:flutter/material.dart';
import 'package:galli_vector_plugin/src/api/methods.dart';
import 'package:galli_vector_plugin/src/current_location.dart';
import 'package:galli_vector_plugin/src/flutter_map_libre/mapbox_gl.dart';
import 'package:galli_vector_plugin/src/search.dart';
import 'package:galli_vector_plugin/src/three_60.dart';
import 'package:geolocator/geolocator.dart';
export 'package:galli_vector_plugin/src/flutter_map_libre/mapbox_gl.dart';

class GalliMap extends StatefulWidget {
  final ({double height, double width}) size;
  final bool showCurrentLocation;
  final bool showCompass;
  final bool showCurrentLocationButton;
  final bool showSearchWidget;
  final bool showThree60Widget;
  final ({CompassViewPosition? position, Point<num>? offset}) compassPosition;
  final Function(GalliMapController controller)? onMapCreated;
  final Function(LatLng latlng)? onMapClick;
  final CameraPosition initialCameraPostion;
  final Function(UserLocation location)? onUserLocationChanged;
  final String authToken;
  final MinMaxZoomPreference minMaxZoomPreference;
  final bool doubleClickZoomEnabled;
  final bool dragEnabled;
  final bool rotateGestureEnabled;
  final bool zoomGestureEnabled;
  final bool tiltGestureEnabled;
  final bool scrollGestureEnabled;
  final Function(LatLng latLng)? onMapLongPress;
  final List<Widget> children;

  const GalliMap(
      {super.key,
      this.showCurrentLocation = true,
      this.showCompass = true,
      this.showSearchWidget = true,
      this.showThree60Widget = true,
      this.compassPosition = (
        position: CompassViewPosition.bottomRight,
        offset: const Point(30, 48)
      ),
      this.showCurrentLocationButton = true,
      this.onMapCreated,
      this.onMapClick,
      required this.size,
      this.initialCameraPostion = const CameraPosition(
          target: LatLng(
            27.677120,
            85.322313,
          ),
          zoom: 18,
          bearing: 0.0,
          tilt: 0),
      this.minMaxZoomPreference = const MinMaxZoomPreference(4.5, 22),
      this.zoomGestureEnabled = true,
      this.doubleClickZoomEnabled = true,
      this.dragEnabled = true,
      required this.authToken,
      this.onUserLocationChanged,
      this.tiltGestureEnabled = true,
      this.scrollGestureEnabled = true,
      this.rotateGestureEnabled = true,
      this.onMapLongPress,
      this.children = const []});

  @override
  State<GalliMap> createState() => _GalliMapState();
}

class _GalliMapState extends State<GalliMap> {
  late GalliMethods galliMethods;
  bool loading = true;

  locationChecker() async {
    if (widget.showCurrentLocation) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
        await Geolocator.getCurrentPosition();
      } else {
        await Geolocator.getCurrentPosition();
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    locationChecker();
    galliMethods = GalliMethods(widget.authToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: loading
          ? const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          : Stack(children: [
              ClipRRect(
                child: Transform.scale(
                  scale: 1,
                  child: MaplibreMap(
                      minMaxZoomPreference: widget.minMaxZoomPreference,
                      doubleClickZoomEnabled: widget.doubleClickZoomEnabled,
                      dragEnabled: widget.dragEnabled,
                      rotateGesturesEnabled: widget.rotateGestureEnabled,
                      zoomGesturesEnabled: widget.zoomGestureEnabled,
                      tiltGesturesEnabled: widget.tiltGestureEnabled,
                      scrollGesturesEnabled: widget.scrollGestureEnabled,
                      onMapLongClick: (Point<num> data, LatLng latlng) {
                        if (widget.onMapLongPress != null) {
                          widget.onMapLongPress!(latlng);
                        }
                      },
                      onMapCreated: (_) async {
                        galliMapController = _;
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        if (widget.onMapCreated != null) {
                          widget.onMapCreated!(_);
                        }
                      },
                      onMapClick: (point, coordinates) async {
                        if (widget.onMapClick != null) {
                          widget.onMapClick!(coordinates);
                        }
                      },
                      trackCameraPosition: true,
                      myLocationEnabled: widget.showCurrentLocation,
                      myLocationRenderMode: widget.showCurrentLocation
                          ? MyLocationRenderMode.compass
                          : MyLocationRenderMode.normal,
                      myLocationTrackingMode: widget.showCurrentLocation
                          ? MyLocationTrackingMode.tracking
                          : MyLocationTrackingMode.none,
                      compassEnabled: widget.showCompass,
                      compassViewPosition: widget.compassPosition.position,
                      compassViewMargins: widget.compassPosition.offset,
                      onUserLocationUpdated: (UserLocation location) {
                        if (widget.onUserLocationChanged != null) {
                          widget.onUserLocationChanged!(location);
                        }
                      },
                      styleString:
                          "https://map-init.gallimap.com/styles/light/style.json?accessToken=${widget.authToken}",
                      initialCameraPosition: widget.initialCameraPostion),
                ),
              ),
              Positioned(
                  bottom: 4,
                  left: 8,
                  child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.centerLeft,
                      child: Image.network(
                        "https://gallimaps.com/images/logo2.png",
                        colorBlendMode: BlendMode.srcIn,
                        color: const Color(0Xff812C19),
                        fit: BoxFit.contain,
                      ))),
              if (galliMapController != null &&
                  widget.showCurrentLocationButton)
                Positioned(
                    bottom: 16,
                    right: 16,
                    child: CurrentLocationWidget(
                      controller: galliMapController!,
                    )),
              if (galliMapController != null && widget.showThree60Widget)
                Positioned(
                    bottom: 73,
                    right: 16,
                    child:
                        Three60ButtonWidget(controller: galliMapController!)),
              if (galliMapController != null && widget.showSearchWidget)
                GalliSearchWidget(
                  width: widget.size.width * 0.9,
                  authToken: widget.authToken,
                  mapController: galliMapController!,
                ),
              for (Widget widget in widget.children) widget
            ]),
    );
  }
}

GalliMapController? galliMapController;
