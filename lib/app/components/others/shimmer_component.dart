import 'package:flutter/material.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComponent extends StatelessWidget {
  final int count;
  final double marginBottom;
  final double marginTop;
  final double marginLeft;
  final double marginRight;

  const ShimmerComponent({
    super.key,
    this.count = 5,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginTop = 0,
  });

  @override
  Widget build(BuildContext context) {
    var shimmers = <Widget>[];

    for (var i = 1; i <= count; i++) {
      shimmers.add(
        Container(
          decoration: BoxDecoration(
            color: MahasColors.light,
            borderRadius: BorderRadius.circular(3),
          ),
          margin: EdgeInsets.only(
            right: marginRight,
            left: marginLeft,
            top: marginTop,
            bottom: i == count ? marginBottom : 8,
          ),
          width: double.infinity,
          height: 16,
        ),
      );
    }
    return Shimmer.fromColors(
      baseColor: MahasColors.dark.withValues(alpha: .1),
      highlightColor: MahasColors.dark.withValues(alpha: .05),
      child: Column(
        children: shimmers,
      ),
    );
  }
}
