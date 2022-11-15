import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/location_controller.dart';

class LocationView extends GetView<LocationController> {
  LocationView({Key? key}) : super(key: key);
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(3.597031, 98.678513),
    zoom: 14.4746,
  );

  static final Marker _kUTDMedanMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(
          title: 'UDD PMI Kota Medan',
          snippet:
              'Jl. Perintis Kemerdekaan No.37, Perintis, Medan Tim., Kota Medan, Sumatera Utara 20233, Indonesia'),
      position: LatLng(3.5991550978764786, 98.68343911197711));

  static final Marker _kPMIMedanMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(
          title: 'Palang Merah Indonesia',
          snippet:
              'Jl. Palang Merah No.17, A U R, Kec. Medan Maimun, Kota Medan, Sumatera Utara 20151'),
      position: LatLng(3.5843766, 98.6779938));

  static final Marker _kPMIPakamMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'PMI Deli Serdang', snippet: ''),
      position: LatLng(3.5582053805470797, 98.86679659253757));

  static final Marker _kUDDPMIPakamMarker = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(
          title: 'UDD PMI Deli Serdang',
          snippet:
              'GVX9+H57, Tj. Garbus Satu, Kec. Lubuk Pakam, Kabupaten Deli Serdang, Sumatera Utara 20517'),
      position: LatLng(3.5489423663426725, 98.86797637335833));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: {
            _kUTDMedanMarker,
            _kPMIMedanMarker,
            _kPMIPakamMarker,
            _kUDDPMIPakamMarker
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
