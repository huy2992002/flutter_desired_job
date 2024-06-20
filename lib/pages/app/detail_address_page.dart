import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_desired_job/components/button/dj_elevated_button.dart';
import 'package:flutter_desired_job/components/button/dj_icon_button.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_desired_job/utils/extension.dart';
import 'package:flutter_desired_job/utils/route.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailAddressPage extends StatefulWidget {
  const DetailAddressPage({
    super.key,
    required this.onSelect,
    // required this.lat,
    // required this.long,
  });

  final Function(LatLng) onSelect;
  // final double lat;
  // final double long;

  @override
  State<DetailAddressPage> createState() => _DetailAddressPageState();
}

class _DetailAddressPageState extends State<DetailAddressPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Position? currentPosition;
  LatLng? selectLatLong;
  Set<Marker> markers = {};
  Marker? currentMarker;

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void _getCurrentLocation() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return;
    }

    try {
      currentPosition = await _geolocatorPlatform.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      );
      // currentMarker = Marker(
      //   zIndex: 9999.0,
      //   markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
      //   position: LatLng(
      //     currentPosition!.latitude,
      //     currentPosition!.longitude,
      //   ),
      //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      // );
      // markers.add(currentMarker!);
      setState(() {});
    } on TimeoutException catch (e) {
      debugPrint('onError $e');
    }
  }

  // Future<void> _addMarker() async {
  //   markers.add(
  //     Marker(
  //       markerId: const MarkerId('99999'),
  //       position: LatLng(widget.lat, widget.long),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //     ),
  //   );
  //   setState(() {});
  // }

  void _onCurrentLocation() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      _getCurrentLocation();
      if (currentPosition != null) {
        final GoogleMapController controller = await _controller.future;
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                currentPosition!.latitude,
                currentPosition!.longitude,
              ),
              zoom: 13.2,
            ),
          ),
        );
      }
    } else {
      await Geolocator.openLocationSettings();
    }
  }

  // void _onBusinessLocation() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: LatLng(
  //           widget.lat,
  //           widget.long,
  //         ),
  //         zoom: 13.2,
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // _addMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                currentPosition?.latitude ?? 16.0544,
                currentPosition?.longitude ?? 108.2022,
              ),
              zoom: 12.0,
            ),
            onTap: (argument) {
              markers.removeWhere(
                (e) => e.mapsId == const MarkerId('select'),
              );

              selectLatLong = argument;
              Marker select = Marker(
                zIndex: 99999.0,
                markerId: const MarkerId('select'),
                position: LatLng(
                  argument.latitude,
                  argument.longitude,
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
                onTap: () {
                  selectLatLong = null;
                  setState(() {
                    markers.removeWhere(
                      (e) => e.mapsId == const MarkerId('select'),
                    );
                  });
                },
              );
              markers.add(select);
              setState(() {});
            },
            markers: markers,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: DJIconButton(
              onPressed: () => RoutePage.pop(context),
              icon: Assets.icons.icChevronLeft,
            ),
          ),
          Positioned(
            left: 20.0,
            bottom: 30.0,
            child: Column(
              children: [
                // _buildButtonMarker(
                //   onTap: _onBusinessLocation,
                //   color: DJColor.hFF0000,
                // ),
                const SizedBox(height: 10.0),
                _buildButtonMarker(
                  onTap: _onCurrentLocation,
                  color: DJColor.h26E543,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 60.0,
            left: 70.0,
            child: DJElevatedButton.small(
              onPressed: selectLatLong != null
                  ? () {
                      widget.onSelect.call(selectLatLong!);
                      Navigator.pop(context);
                    }
                  : null,
              text: context.l10n.select,
              color: selectLatLong != null ? DJColor.h69B6C7 : DJColor.h8FE1DC,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonMarker({Function()? onTap, Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: color?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          Icons.location_on_outlined,
          color: color,
        ),
      ),
    );
  }
}
