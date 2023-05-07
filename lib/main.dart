import 'package:advice_clean_arch/core/di/injection.dart';
import 'package:advice_clean_arch/presentation/pages/advice/advice.dart';
import 'package:advice_clean_arch/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/core/service/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const AdvicePageWrapper(),
      );
    });
  }
}
