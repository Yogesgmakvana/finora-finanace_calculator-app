import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FinoraApp());
}

class FinoraApp extends StatelessWidget {
  const FinoraApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'Finora',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: Routes.SPLASH,
        getPages: AppPages.pages,
      );
}

// Kept as a compatibility name for the starter widget test and IDE previews.
class MyApp extends FinoraApp {
  const MyApp({super.key});
}
