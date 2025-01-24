import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:project_tes2/app/components/mahas_service.dart';
import 'package:project_tes2/app/components/mahas_themes.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // Initial intl locale format
  await initializeDateFormatting('id_ID');
  Intl.defaultLocale = 'id_ID';
  await MahasService.init();
  runApp(
    OverlaySupport.global(
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // Specify supported locales
        supportedLocales: const [
          Locale('id', 'ID'), // Indonesian locale
          Locale('en', 'US'), // English locale
        ],
        locale: const Locale('id', 'ID'), // Default use Indonesia location
        debugShowCheckedModeBanner: false,
        title: "Laporan Masyarakat Diskominfo Badung",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        builder: EasyLoading.init(),
        theme: MahasThemes.light,
      ),
    ),
  );
}
