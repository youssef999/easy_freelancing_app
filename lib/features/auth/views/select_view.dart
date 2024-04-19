

// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';

class SelectView extends StatelessWidget {
  const SelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:CustomAppBar('', context, false),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child:const Column(children: [
          SizedBox(height: 10,),
        ]),
      ),
    );
  }
}