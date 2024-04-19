




// ignore_for_file: avoid_print, unused_local_variable, depend_on_referenced_packages

import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/features/emp/views/map_view_3.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/widgets/Custom_button.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../map_controller.dart';
import '../../predict_places.dart';


// ignore: must_be_immutable
class SearchPlacesView2 extends StatefulWidget



{
  Map<String,dynamic>data;
  
   SearchPlacesView2({super.key,required this.data});
  @override
  // ignore: library_private_types_in_public_api
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}

TextEditingController searchController=TextEditingController();

class _SearchPlacesScreenState extends State<SearchPlacesView2>
{
  List<PredictedPlaces> placesPredictedList = [];

  MapController controller=Get.put(MapController());

  String mapKey=
  // 'AIzaSyCKckCh7RP4ezDtY4F2m5CEV0Y8tfntDFk';
'AIzaSyCdLsB9Sjir6fW0ZjJ1mksJvxMrRIZR7d4';

  @override
  void dispose() {
    searchController.text='';
    super.dispose();

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: CustomAppBar('enterPlace'.tr, context,false),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
            text: 'next'.tr,
            onPressed: (){
              if(searchController.text.length>2){

                Get.to(  MapViewSelect2(data: widget.data,));
                
                final box = GetStorage();
                box.write('location',searchController.text);
              }
          
              else{
                appMessage(text: 'enterPlace'.tr, fail: true);
              }
              // Get.toNamed('/AddSeller');
            },
            color1:AppColors.buttonColor,
            color2:   AppColors.buttonColor2
        ),
      ),
      body: GetBuilder<MapController>(
          builder: (context) {
            return Column(
              children: [
                const SizedBox(height: 22,),
                //search place ui
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [

                          Row(
                            children: [
                              Icon(
                                  Icons.adjust_sharp,
                                  color: AppColors.primary
                              ),

                              const SizedBox(width: 18.0,),


                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 290,
                                  child: TextField(

                                    controller: searchController,

                                    onChanged: (valueTyped)
                                    {

                                      findPlaceAutoCompleteSearch(valueTyped);
                                    },
                                    decoration:   InputDecoration(
                                      hintText: "search".tr,
                                      filled: true,
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                        left: 11.0,
                                        top: 8.0,
                                        bottom: 8.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22,),
                //display place predictions result
                (placesPredictedList.isNotEmpty)
                    ? Expanded(
                  child:
                  SizedBox(
                    height: 250,
                    child: ListView.separated(
                      itemCount: placesPredictedList.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index)
                      {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: PlacePredictionTileDesign(
                            predictedPlaces: placesPredictedList[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index)
                      {
                        return const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Divider(
                              height: 1,
                              color: Colors.cyan,
                              thickness: 0.2
                          ),
                        );
                      },
                    ),
                  ),
                )
                    : Container(
                  color:AppColors.backgroundColor,
                ),


              ],
            );
          }
      ),
    );
  }
  void findPlaceAutoCompleteSearch(String inputText) async
  {
    print("sssXXXXXXssss...................");
    if(inputText.isNotEmpty) //2 or more than 2 input characters
        {
      String urlAutoCompleteSearch =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:DZ";
      var responseAutoCompleteSearch =
      await receiveRequest(urlAutoCompleteSearch);
      if(responseAutoCompleteSearch == "Error Occurred, Failed. No Response.")
      {
        print("ERRRORRRR");
        return;
      }
      if(responseAutoCompleteSearch["status"] == "OK")
      {
        print("OK");
        var placePredictions = responseAutoCompleteSearch["predictions"];
        print("PLACE==${placePredictions[0]}");
        var placePredictionsList = (placePredictions as List)
            .map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();

        setState(() {
          placesPredictedList = placePredictionsList;
        });
        
        print("//////////.......................");
        print(placesPredictedList.first.main_text.toString());
        print(placesPredictedList.first.place_id.toString());
        print("//////////.......................");
      }
      else{
      }
      print("ELSE");
      print(responseAutoCompleteSearch["status"]);
      print(responseAutoCompleteSearch);
    }
  }


  static Future<dynamic> receiveRequest(String url) async
  {
    http.Response httpResponse = await http.get(Uri.parse(url));

    try
    {
      if(httpResponse.statusCode == 200) //successful
          {
        String responseData = httpResponse.body; //json

        var decodeResponseData = jsonDecode(responseData);

        return decodeResponseData;
      }
      else
      {
        return "Error Occurred, Failed. No Response.";
      }
    }
    catch(exp)
    {
      return "Error Occurred, Failed. No Response.";
    }
  }
// final controller=Get.put(HomeController());
}



class PlacePredictionTileDesign extends StatelessWidget
{
  final controller=Get.put(MapController());
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({super.key, this.predictedPlaces});

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: ()
      {
        searchController.text= predictedPlaces!.main_text!;

        print('sss222');

        controller.getLatLng(predictedPlaces!.main_text!);
      },

      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Icon(
              Icons.add_location,
              color: AppColors.primary,
            ),
            const SizedBox(width: 14.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0,),
                  Text(
                    predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2.0,),
                  Text(
                    predictedPlaces!.secondary_text!,
                    overflow: TextOverflow.ellipsis,
                    style:  const TextStyle(
                      fontSize: 12.0,
                      // color: AppColors.greyColotHelper
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}