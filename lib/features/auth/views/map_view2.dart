//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:freelancerApp/Core/resources/app_colors.dart';
// import 'package:freelancerApp/core/widgets/Custom_button.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../core/widgets/custom_app_bar.dart';
// import '../../map_controller2.dart';
//
//
// class MapView extends StatelessWidget {
//   const MapView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller2=Get.put(MapController());
//     print("///xxx///////");
//     print(controller2.lat);
//     print(controller2.lng);
//     print("/////xxx/////");
//     return  Scaffold(
//       appBar: CustomAppBar('enterPlace'.tr, context,false),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: controller2.changeCameraPosition,
//             tooltip: 'Change Camera Position',
//             child: const Icon(Icons.center_focus_strong),
//           ),
//           const SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: controller2.changeMarkerPosition,
//             tooltip: 'Change Marker Position',
//             child: const Icon(Icons.location_searching),
//           ),
//         ],
//       ),
//       body:ListView(
//         children: [
//           const SizedBox(height: 10,),
//           Center(
//             child: Text(controller2.nameLocation,
//               style:const TextStyle(fontSize: 18,
//                   fontWeight: FontWeight.w700
//               ),
//             ),
//           ),
//           const SizedBox(height: 21,),
//           SizedBox(
//             height: 500,
//             child: GetBuilder<MapController>(
//                 builder: (_) {
//                   return GoogleMap(
//                     zoomControlsEnabled:true,
//                     onMapCreated: (controller) {
//                       controller2.onMapCreated(controller);
//                     },
//                     initialCameraPosition: CameraPosition(
//                       target: LatLng(controller2.lat, controller2.lng),
//                       zoom: 15.0,
//                     ),
//                     onCameraMove: controller2.onCameraMove,
//                     markers :{controller2.userLocationMarker},
//                     // {
//                     //   Marker(
//                     //     markerId: MarkerId("userLocation"),
//                     //     position: LatLng(controller2.lat ?? 0.0,
//                     //         controller2.lng ?? 0.0),
//                     //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//                     //     infoWindow: InfoWindow(
//                     //       title: "Your Location",
//                     //       snippet: "Lat: ${controller2.lat},"
//                     //           " Lng: ${controller2.lng}",
//                     //     ),
//                     //   ),
//                     // },
//                   );
//                 }
//             ),
//           ),
//           const SizedBox(height: 11,),
//           Padding(
//             padding: const EdgeInsets.all(33.0),
//             child: SizedBox(
//               width: 166,
//               child: CustomButton(text: 'next'.tr,
//                   onPressed:(){
//
//
//
//                   }, color1: AppColors.buttonColor
//                   , color2: Colors.white),
//             ),
//           )
//
//         ],),
//     );
//   }
// }
