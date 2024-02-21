import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double? height;
  final TextAlign? textAlign;

  const ReusableText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    this.height,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height ?? 0,
      ),
      textAlign: textAlign,
    );
  }
}
