import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_tes2/app/components/mahas_themes.dart';
import 'package:project_tes2/app/components/others/button_component.dart';
import 'package:project_tes2/app/components/texts/text_component.dart';
import 'package:shimmer/shimmer.dart';
import 'mahas_colors.dart';
import 'mahas_font_size.dart';

class MahasWidget {
  PreferredSizeWidget mahasAppBar({
    required String title,
    Color background = MahasColors.main,
    IconData backIcon = Icons.arrow_back_ios,
    Color appBarItemColor = MahasColors.light,
    double elevation = 4,
    Function()? onBackTap,
    bool isLeading = true,
    TextAlign titleAlign = TextAlign.center,
    List<Widget>? actionBtn,
  }) {
    return AppBar(
      elevation: elevation,
      centerTitle: false,
      title: TextComponent(
        value: title,
        fontSize: MahasFontSize.actionBartitle,
        fontColor: appBarItemColor,
        fontWeight: FontWeight.w500,
        textAlign: titleAlign,
      ),
      backgroundColor: background,
      leading: isLeading == true
          ? IconButton(
              onPressed: onBackTap ??
                  () {
                    Get.back(result: true);
                  },
              icon: Icon(backIcon),
            )
          : null,
      iconTheme: IconThemeData(
        color: appBarItemColor,
      ),
      actions: actionBtn,
    );
  }

  Widget hideWidget() {
    return Visibility(visible: false, child: Container());
  }

  Widget loadingWidget({Widget? customWidget}) {
    return customWidget != null
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: true,
            child: customWidget)
        : const Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: MahasColors.main,
                ),
              ),
            ],
          );
  }

  static Widget bottomSheetContent({
    required List<Widget> children,
    bool withPill = true,
    double? height,
  }) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 12),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (withPill) ...[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 5,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: MahasColors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            ...children,
          ],
        ),
      ),
    );
  }

  Widget customLoadingWidget({double? width}) {
    return Container(
      height: 15,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: MahasColors.light,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  static Future dialogCustomWidget(List<Widget> children,
      {List<Widget>? actions}) async {
    await Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(MahasThemes.borderRadius))),
        content: Column(mainAxisSize: MainAxisSize.min, children: children),
        contentPadding:
            const EdgeInsets.only(bottom: 0, top: 20, right: 10, left: 10),
        actionsPadding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        actions: actions,
      ),
    );
  }

  static Future<bool?> dialogConfirmation({
    String? title,
    String? message,
    IconData? icon,
    Widget? content,
    String? textConfirm,
    String? textCancel,
    bool isWithBatal = false,
    bool barrierDissmisible = true,
    bool onlyShowConfirm = false,
  }) async {
    return await Get.dialog<bool?>(
      AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        actionsPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(MahasThemes.borderRadius),
          ),
        ),
        content: Column(
          crossAxisAlignment: title != null
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: icon != null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Icon(
                  icon,
                  size: 50,
                  color: MahasColors.danger,
                ),
              ),
            ),
            Visibility(
              visible: title != null,
              child: Column(
                children: [
                  TextComponent(
                    value: title ?? "",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: MahasColors.grey),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Visibility(
              visible: message != null,
              child: TextComponent(
                value: message,
                textAlign: TextAlign.center,
                fontSize: 13,
                fontWeight: title != null ? FontWeight.w400 : FontWeight.w500,
              ),
            ),
            Visibility(
              visible: content != null,
              child: content ?? Container(),
            ),
          ],
        ),
        actions: [
          const Divider(color: MahasColors.grey),
          IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: onlyShowConfirm
                  ? ButtonComponent(
                      btnColor: MahasColors.primary,
                      text: textConfirm ?? "Submit",
                      isMultilineText: true,
                      borderRadius: 3,
                      onTap: () {
                        Get.back(result: true);
                      },
                    )
                  : isWithBatal
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Flexible(
                              child: ButtonComponent(
                                btnColor: MahasColors.primary,
                                text: textConfirm ?? "Submit",
                                isMultilineText: true,
                                borderRadius: 3,
                                onTap: () {
                                  Get.back(result: true);
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Flexible(
                              child: ButtonComponent(
                                text: textCancel ?? "Batal",
                                isMultilineText: true,
                                borderColor: MahasColors.grey,
                                btnColor: MahasColors.light,
                                textColor: MahasColors.dark,
                                borderRadius: 3,
                                onTap: () {
                                  Get.back(result: false);
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Flexible(
                              child: ButtonComponent(
                                text: "Batal",
                                isMultilineText: true,
                                borderColor: MahasColors.grey,
                                btnColor: MahasColors.light,
                                textColor: MahasColors.dark,
                                borderRadius: 3,
                                onTap: Get.back,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Flexible(
                              child: ButtonComponent(
                                text: textCancel ?? "Batal",
                                isMultilineText: true,
                                borderColor: MahasColors.grey,
                                btnColor: MahasColors.light,
                                textColor: MahasColors.dark,
                                borderRadius: 3,
                                onTap: () {
                                  Get.back(result: false);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: ButtonComponent(
                                btnColor: MahasColors.primary,
                                text: textConfirm ?? "Submit",
                                isMultilineText: true,
                                borderRadius: 3,
                                onTap: () {
                                  Get.back(result: true);
                                },
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ],
      ),
      barrierDismissible: barrierDissmisible,
    );
  }

  static Future dialogSuccess(String? message) async {
    await Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FontAwesomeIcons.checkToSlot,
              color: MahasColors.primary,
              size: 40,
            ),
            const Padding(padding: EdgeInsets.all(7)),
            Text(
              textAlign: TextAlign.center,
              message ?? "-",
              style: const TextStyle(
                color: MahasColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
