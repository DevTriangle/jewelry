import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/screens/auth_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jewelry/view/screens/main_screen.dart';
import 'package:jewelry/viewmodel/catalog_viewmodel.dart';
import 'package:jewelry/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CatalogViewModel()),
      ChangeNotifierProvider(create: (_) => OrderViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> getPhone(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? phone = sharedPreferences.getString("phone");

    if (phone == null) {
      return "";
    } else {
      return phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jewelry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: false,
          primaryColor: AppColors.primary,
          cardColor: AppColors.cardColor,
          scaffoldBackgroundColor: AppColors.background,
          backgroundColor: AppColors.background),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FutureBuilder(
        future: getPhone(context),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data != "") {
              return const MainScreen();
            } else {
              return const AuthScreen();
            }
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
