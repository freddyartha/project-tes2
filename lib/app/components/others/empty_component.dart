import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';

import '../mahas_themes.dart';

class EmptyComponent extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isCard;
  final double padding;
  final bool isOnlyBottomBorder;

  const EmptyComponent({
    super.key,
    this.onPressed,
    this.isCard = false,
    this.padding = 15,
    this.isOnlyBottomBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isCard
          ? Padding(
              padding: isOnlyBottomBorder
                  ? EdgeInsets.only(
                      bottom: padding,
                      right: padding,
                      left: padding,
                    )
                  : EdgeInsets.all(padding),
              child: Card(
                color: MahasColors.light,
                margin: isOnlyBottomBorder ? EdgeInsets.zero : null,
                shape: isOnlyBottomBorder
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(MahasThemes.borderRadius),
                          bottomRight:
                              Radius.circular(MahasThemes.borderRadius),
                        ),
                      )
                    : MahasThemes.cardBorderShape,
                elevation: 3,
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.boxOpen,
                        size: 40,
                        color: MahasColors.dark.withValues(alpha: .3),
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "Tidak ada data",
                        style: TextStyle(
                          color: MahasColors.dark.withValues(alpha: .3),
                        ),
                      ),
                      Visibility(
                        visible: onPressed != null,
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(5)),
                            TextButton(
                              onPressed: onPressed,
                              child: const Text(
                                "Refresh",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.boxOpen,
                  size: 40,
                  color: MahasColors.dark.withValues(alpha: .3),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Text(
                  "Tidak ada data",
                  style: TextStyle(
                    color: MahasColors.dark.withValues(alpha: .3),
                  ),
                ),
                Visibility(
                  visible: onPressed != null,
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(5)),
                      TextButton(
                        onPressed: onPressed,
                        child: const Text(
                          "Refresh",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
