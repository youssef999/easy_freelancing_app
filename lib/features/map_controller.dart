
// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, depend_on_referenced_packages, unused_import

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart'as loc;

class MapController extends GetxController {


  TextEditingController dateController=TextEditingController();
  dynamic dateTime='';
  double lat=30.106505499999997;
  double lng=31.375252500000002;
  String nameLocation='';
  late Marker userLocationMarker;
  late loc.LocationData currentLocation;

  //Time time = const Time(hour: 11, minute: 30, second: 20);

  @override
  void onReady() {
    //checkLocationPermission();
    getLocation();

    super.onReady();
  }
  void changeMarkerPosition() {
    userLocationMarker = userLocationMarker.copyWith(
      positionParam: LatLng(
        lat ,
        lng ,
      ),
    );
    update();
  }


  String placeNamex='';
  LatLng currentLatLng = const LatLng(37.422004313390126,
      -122.08400756120682);
  double zoom = 13.0;
  double latx=37.422004313390126;
  double lngx=-122.08400756120682;

  TextEditingController searchController=TextEditingController();
  GoogleMapController? mapController2;


  void onMapCreated(GoogleMapController controller) {
    mapController2 = controller;
    update();
  }

  Future<void> getLocation() async {
    // Location location = Location(latitude: lat,
    // longitude: lng, timestamp: DateTime.now()
    // );

    try {

      //   loc.LocationData userLocation = await location.getLocation();
      //setState(() {
      //currentLocation = userLocation;
      userLocationMarker = Marker(
        markerId: const MarkerId("userLocation"),
        position: LatLng(lat?? 0.0, lng?? 0.0),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: "Your Location",
          snippet: "Lat: ${lat}, Lng: ${lng}",
        ),
      );

      update();

    } catch (e) {
      print("Error: $e");
    }
  }


  selectDate(var value){

    dateTime=value;
    update();
  }

  void changeCameraPosition() {
    mapController2!.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(lat?? 0.0, lng ?? 0.0),
        17.0, // Zoom level, you can adjust this value
      ),
    );
    update();
  }


  Future<void> checkLocationPermission() async {

    print("HERE");
    LocationPermission permission = await Geolocator.checkPermission();

    //permission = await Geolocator.requestPermission();

    getCurrentLocation();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        print("DENIED");
        return;
      }
      getCurrentLocation();
    }
    else{
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      getCurrentLocation();
    }
  }



  //Future<Map<String, dynamic>>
  getLatLng(String placeName) async {

    print("name==$placeName");

    List<Location> locations = await locationFromAddress(placeName);
    Location firstLocation = locations.first;
    String locationInfo =
        'Place: $placeName\nLatitude: ${firstLocation.latitude}\nLongitude: ${firstLocation.longitude}';

    print("INFO===$locationInfo");
    print("////");
    lat=firstLocation.latitude;
    lng=firstLocation.longitude;
    nameLocation=placeName;


    //   print("MAAAAAAPPPPP");
    //   String apiKey = 'AIzaSyDA-D-AYyDPASQgA2p98xxzZHXMusGcblk';
    //   //'AIzaSyBo94cx-aOPjxB9wyZjUqSf5v58qE4cQ3I';
    //   //'AIzaSyCKckCh7RP4ezDtY4F2m5CEV0Y8tfntDFk';
    //   //'AIzaSyBCRjQbAjjWsve_mxS2qcO2moflRSffGoo';
    //   String encodedPlaceName = Uri.encodeQueryComponent(placeName);
    //   String url =
    // 'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedPlaceName&key=$apiKey';
    //
    //
    //   final response = await http.get(Uri.parse(url));
    //
    //   if (response.statusCode == 200) {
    //     print("///");
    //     print(response.body);
    //      print("///");
    //     print("200wwwweeeee");
    //     final decodedResponse = json.decode(response.body);
    //     final results = decodedResponse['results'];
    //
    //     if (results.isNotEmpty) {
    //       print("not empty");
    //       final location = results[0]['geometry']['location'];
    //       final lat = location['lat'];
    //       final lng = location['lng'];
    //
    //       print(lat);
    //       print(lng);
    //
    //       latx=lat;
    //       lngx=lng;
    //
    //       currentLatLng=LatLng(latx, lngx);
    //
    //       placeNamex=placeName;

    update();
    updateCameraPosition(lat,lng);
    // return {'lat': lat, 'lng': lng};

    // }
    // else{
    //   print("empty");
    // }
  }


  // else{
  //   print("xxxx0000000");
  //
  // }
  //  return {'lat': 0.0, 'lng': 0.0};
  //return null;


  void onCameraMove(CameraPosition position) {
    print("move");
    currentLatLng = position.target;
    lat=currentLatLng.latitude;
    lng=currentLatLng.longitude;
    userLocationMarker = userLocationMarker.copyWith(
      positionParam: position.target,
    );
    print("xxxxxxccc");
    print(lat);
    print(lng);
    print('////////////////');
    changeMarkerPosition();
    update();
  }




  Future<void> getCurrentLocation() async {
    print("Current");
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latx = position.latitude;

    lngx = position.longitude;

    print('Latitude: $latx, Longitude: $lngx');
    updateCameraPosition(latx,lngx);

  }



  void updateCameraPosition(double lat, double lng) {
    print("UPDATE");
    print(lat);
    print(lng);
    print("UPDATE");

    currentLatLng = LatLng(lat, lng);
    zoom = 13.0; // You can set a different zoom level if needed
    latx=currentLatLng.latitude;
    lngx=currentLatLng.longitude;
    mapController2
        ?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, zoom));

    update();
  }
}
