import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';
import 'package:project_tes2/app/components/mahas_font_size.dart';
import 'package:project_tes2/app/components/mahas_widget.dart';

class TextComponent extends StatelessWidget {
  final String? value;
  final Color fontColor;
  final FontWeight fontWeight;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final bool isMuted;
  final TextAlign textAlign;
  final int? maxLines;
  final double? textheight;
  final Function()? onTap;
  final EdgeInsetsGeometry margin;
  final bool isLoading;
  const TextComponent({
    super.key,
    @required this.value,
    this.fontColor = MahasColors.dark,
    this.onTap,
    this.isMuted = false,
    this.fontWeight = FontWeight.normal,
    this.fontSize = MahasFontSize.normal,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.maxLines,
    this.textheight,
    this.textAlign = TextAlign.start,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MahasWidget().loadingWidget(
            customWidget: Container(
              height: 15,
              margin: const EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                color: MahasColors.light.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          )
        : Container(
            margin: margin,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: padding,
                child: Text(
                  value!,
                  maxLines: maxLines,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: fontColor.withValues(alpha: isMuted ? .55 : 1),
                      height: textheight,
                    ),
                  ),
                  textAlign: textAlign,
                  overflow: maxLines != null ? TextOverflow.ellipsis : null,
                ),
              ),
            ),
          );
  }
}
