import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';
import 'package:project_tes2/app/components/mahas_font_size.dart';
import 'package:project_tes2/app/components/mahas_widget.dart';

import '../texts/text_component.dart';

class TwoRowComponent extends StatelessWidget {
  final String? title;
  final String? data;
  final int? titleMaxLines;
  final int? dataMaxLines;
  final double? paddingWidth;
  final double titleWidth;
  final TextAlign titleAlign;
  final TextAlign dataAlign;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry dataPadding;
  final double titleFontSize;
  final double dataFontSize;
  final bool titleMuted;
  final bool dataMuted;
  final Color titleColor;
  final Color dataColor;
  final FontWeight titleFontWeight;
  final FontWeight dataFontWeight;
  final bool isTitleIcon;
  final IconData? titleIcon;
  final bool isDataIcon;
  final IconData? dataIcon;
  final Alignment titleIconAlign;
  final Alignment dataIconAlign;
  final Function()? titleOnTap;
  final Function()? dataOnTap;
  final bool isCustomDataWidget;
  final Widget? dataCustomWidget;
  final bool isLoadingAll;
  final bool isLoadingData;
  const TwoRowComponent({
    super.key,
    this.title,
    this.data,
    this.titleMaxLines,
    this.dataMaxLines,
    this.paddingWidth = 10,
    this.titleWidth = 0.3,
    this.titleAlign = TextAlign.start,
    this.dataAlign = TextAlign.start,
    this.titlePadding = const EdgeInsets.only(top: 5),
    this.dataPadding = const EdgeInsets.only(top: 5),
    this.titleFontSize = MahasFontSize.normal,
    this.dataFontSize = MahasFontSize.normal,
    this.titleMuted = false,
    this.dataMuted = false,
    this.titleColor = MahasColors.dark,
    this.dataColor = MahasColors.dark,
    this.titleFontWeight = FontWeight.normal,
    this.dataFontWeight = FontWeight.normal,
    this.isTitleIcon = false,
    this.titleIcon,
    this.isDataIcon = false,
    this.dataIcon,
    this.titleIconAlign = Alignment.bottomLeft,
    this.dataIconAlign = Alignment.bottomLeft,
    this.titleOnTap,
    this.dataOnTap,
    this.isCustomDataWidget = false,
    this.dataCustomWidget,
    this.isLoadingAll = false,
    this.isLoadingData = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoadingAll
        ? Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MahasWidget().loadingWidget(
                  customWidget: Container(
                    height: 15,
                    margin: const EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                      color: MahasColors.light.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                SizedBox(
                  width: paddingWidth,
                ),
                Expanded(
                  child: MahasWidget().loadingWidget(
                    customWidget: Container(
                      height: 15,
                      margin: const EdgeInsets.only(bottom: 3),
                      decoration: BoxDecoration(
                        color: MahasColors.light.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : isLoadingData
            ? Row(
                children: [
                  SizedBox(
                    width: Get.width * titleWidth,
                    child: isTitleIcon
                        ? Align(
                            alignment: titleIconAlign,
                            child: Icon(
                              titleIcon ?? Icons.person,
                              size: 25,
                            ),
                          )
                        : TextComponent(
                            padding: titlePadding,
                            value: title,
                            fontColor: titleColor,
                            maxLines: titleMaxLines,
                            textAlign: titleAlign,
                            isMuted: titleMuted,
                            fontWeight: titleFontWeight,
                            onTap: titleOnTap,
                            fontSize: titleFontSize,
                          ),
                  ),
                  Container(
                    width: paddingWidth,
                    color: MahasColors.light,
                  ),
                  Expanded(
                    child: MahasWidget().loadingWidget(
                      customWidget: Container(
                        height: 15,
                        margin: const EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                          color: MahasColors.light.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * titleWidth,
                    child: isTitleIcon
                        ? Align(
                            alignment: titleIconAlign,
                            child: Icon(
                              titleIcon ?? Icons.person,
                              size: 25,
                            ),
                          )
                        : TextComponent(
                            padding: titlePadding,
                            value: title ?? "",
                            fontColor: titleColor,
                            maxLines: titleMaxLines,
                            textAlign: titleAlign,
                            isMuted: titleMuted,
                            fontWeight: titleFontWeight,
                            onTap: titleOnTap,
                            fontSize: titleFontSize,
                          ),
                  ),
                  SizedBox(
                    width: paddingWidth,
                  ),
                  Expanded(
                    child: isCustomDataWidget
                        ? SizedBox(
                            child: dataCustomWidget,
                          )
                        : SizedBox(
                            width: Get.width,
                            child: isDataIcon
                                ? Align(
                                    alignment: dataIconAlign,
                                    child: Icon(
                                      dataIcon ?? Icons.person,
                                      size: 25,
                                    ),
                                  )
                                : TextComponent(
                                    padding: titlePadding,
                                    value: data ?? "",
                                    fontColor: dataColor,
                                    maxLines: dataMaxLines,
                                    textAlign: dataAlign,
                                    isMuted: dataMuted,
                                    fontWeight: dataFontWeight,
                                    onTap: dataOnTap,
                                    fontSize: dataFontSize,
                                  ),
                          ),
                  ),
                ],
              );
  }
}
