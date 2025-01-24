// import 'package:flutter/material.dart';
// import 'package:hr_portal/app/mahas/components/others/button_component.dart';
// import 'package:hr_portal/app/mahas/components/texts/text_component.dart';
// import 'package:hr_portal/app/mahas/mahas_font_size.dart';
// import '../../mahas_colors.dart';
// import '../mahas_themes.dart';

// class NoInternetConnectionPage extends StatelessWidget {
//   final Function()? onPressed;
//   final String? message;
//   final Color textColor;
//   final Color textButtonColor;

//   const NoInternetConnectionPage({
//     super.key,
//     this.onPressed,
//     this.message,
//     this.textColor = MahasColors.dark,
//     this.textButtonColor = MahasColors.light,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               "assets/images/no_internet.png",
//               width: MediaQuery.of(context).orientation == Orientation.portrait
//                   ? MediaQuery.of(context).size.width * 0.6
//                   : MediaQuery.of(context).size.width * 0.3,
//             ),
//             TextComponent(
//               value: "Terjadi Kesalahan!",
//               fontSize: MahasFontSize.h3,
//               fontWeight: FontWeight.bold,
//               textAlign: TextAlign.center,
//               fontColor: textColor,
//               margin: const EdgeInsets.only(top: 10),
//             ),
//             TextComponent(
//               value: message ??
//                   "Pastikan internetmu lancar, cek ulang jaringan di tempatmu",
//               fontSize: MahasFontSize.h6,
//               textAlign: TextAlign.center,
//               fontColor: textColor,
//               maxLines: 10,
//               margin: const EdgeInsets.only(bottom: 40),
//             ),
//             Visibility(
//               visible: onPressed != null ? true : false,
//               child: ButtonComponent(
//                 onTap: onPressed ?? () {},
//                 text: "Coba Lagi",
//                 fontSize: MahasFontSize.h6,
//                 fontWeight: FontWeight.w600,
//                 textColor: textButtonColor,
//                 btnColor: MahasColors.primary,
//                 borderColor: MahasColors.light,
//                 borderRadius: MahasThemes.borderRadius,
//                 width: MediaQuery.of(context).size.width,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
