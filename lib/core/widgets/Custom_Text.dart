import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Custom_Text extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final Color color;
  final FontWeight fontWeight;
  final Alignment alignment;
  final double height;

  const Custom_Text(
      {super.key, required this.text,
      this.fontSize = 16.0,
        this.fontWeight=FontWeight.w500,
        this.textAlign=TextAlign.center,
      this.color = Colors.black,
      this.alignment = Alignment.center,
      this.height = 1});

  @override
  Widget build(BuildContext context) {
    return 
     Text(  
        text,
          style: GoogleFonts.cairo(
            color:color,
            fontSize: fontSize,
              fontWeight:fontWeight,
          )
      
    );
  }
}

