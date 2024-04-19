




import 'package:flutter/material.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/features/map_controller.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/widgets/custom_app_bar.dart';

class MapViewSelect extends GetView<MapController> {
  const MapViewSelect({super.key});

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: CustomAppBar('enterPlace'.tr, context,false),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: controller.changeCameraPosition,
            tooltip: 'Change Camera Position',
            child: const Icon(Icons.center_focus_strong),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: controller.changeMarkerPosition,
            tooltip: 'Change Marker Position',
            child: const Icon(Icons.location_searching),
          ),
        ],
      ),
      body:ListView(
        children: [
          const SizedBox(height: 10,),
          Center(
            child: Text(controller.nameLocation,
              style:const TextStyle(fontSize: 18,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          const SizedBox(height: 21,),
          SizedBox(
            height: 500,
            child: GetBuilder<MapController>(
                builder: (_) {
                  return GoogleMap(
                    zoomControlsEnabled:true,
                    onMapCreated: (controllerx) {
                      controller.onMapCreated(controllerx);
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(controller.lat, controller.lng),
                      zoom: 15.0,
                    ),
                    onCameraMove: controller.onCameraMove,
                    markers :{controller.userLocationMarker},
                    // {
                    //   Marker(
                    //     markerId: MarkerId("userLocation"),
                    //     position: LatLng(controller.lat ?? 0.0,
                    //         controller.lng ?? 0.0),
                    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                    //     infoWindow: InfoWindow(
                    //       title: "Your Location",
                    //       snippet: "Lat: ${controller.lat},"
                    //           " Lng: ${controller.lng}",
                    //     ),
                    //   ),
                    // },
                  );
                }
            ),
          ),
          const SizedBox(height: 11,),
          Padding(
            padding: const EdgeInsets.all(33.0),
            child: SizedBox(
              width: 166,
              child: CustomButton(text: 'next'.tr,
                  onPressed:(){
                        final box = GetStorage();
                    box.write('lat',controller.lat);
                    box.write('lng',controller.lng);
                      Get.offNamed(Routes.REGISTER);
                  }, color1: Colors.black
                  , color2: Colors.black),
            ),
          )

        ],),
    );
  }
}
