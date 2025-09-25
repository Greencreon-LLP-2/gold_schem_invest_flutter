import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:provider/provider.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';
import 'package:rajakumari_scheme/core/services/package_info_service.dart';
import 'package:rajakumari_scheme/core/services/shared_pref_service.dart';

import 'package:rajakumari_scheme/features/gold_scheme/controller/invest_in_scheme_controller.dart';
import 'package:rajakumari_scheme/features/home/controllers/banner_controller.dart';
import 'package:rajakumari_scheme/features/passbook/controller/invest_more_controller.dart';
import 'package:rajakumari_scheme/features/passbook/controller/monthly_payment_controller.dart';
import 'package:rajakumari_scheme/features/passbook/controller/passbook_details_controller.dart';
import 'package:rajakumari_scheme/features/passbook/controller/passbook_list_controller.dart';
import 'package:rajakumari_scheme/features/passbook/services/invest_more_service.dart';
import 'package:rajakumari_scheme/features/passbook/services/monthly_payment_service.dart';
import 'package:rajakumari_scheme/features/passbook/services/passbook_list_service.dart';

import 'package:rajakumari_scheme/features/schedule_visit/controller/schedule_visit_controller.dart';
import 'package:rajakumari_scheme/features/splashscreen/view/splashscreen.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';

void main() async {
  // Ensure Flutter is initialized before accessing platform channels
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences service
  await SharedPrefService.init();

  // Initialize package info service
  await PackageInfoService.init();
  await AppConfig.initAppInfo();
  runApp(Phoenix(child: const MyApp()));
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BannerController()),
        ChangeNotifierProvider(create: (_) => ScheduleVisitController()),
        ChangeNotifierProvider(create: (_) => AuthStateService()),
        ChangeNotifierProvider(
          create:
              (_) => PassbookListController(
                PassbookListService(),
                AuthStateService(),
              ),
        ),
        ChangeNotifierProvider(create: (_) => PassbookDetailsController()),
        ChangeNotifierProvider(
          create: (_) => MonthlyPaymentController(MonthlyPaymentService()),
        ),
        ChangeNotifierProvider(
          create: (_) => InvestMoreController(InvestMoreService()),
        ),
        ChangeNotifierProvider(create: (_) => InvestInSchemeController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 90, 22, 102),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
