import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:test_app/profile_screen.dart";
import "package:test_app/provider_state_management/example_two_provider.dart";
import "package:test_app/provider_state_management/favourite_provider.dart";
import "package:test_app/provider_state_management/list_provider.dart";
import "package:test_app/provider_state_management/sp_login_screen_provider.dart";
import "package:test_app/provider_state_management/theme_changer_provider.dart";
import "package:test_app/provider_state_management/theme_provider.dart";
import "package:test_app/themes/app_theme.dart";


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NumbersProvider()),
        ChangeNotifierProvider(create: (context) => ExampleTwoProvider()),
        ChangeNotifierProvider(create: (context) => FavouriteProvider()),
        ChangeNotifierProvider(create: (context) => ThemeChangerProvider()),
        ChangeNotifierProvider(create: (context) => SpLoginScreenProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          // final themeProvider = Provider.of<ThemeChangerProvider>(context);
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) => MaterialApp(
              title: "Learning Flutter",
              home: ProfileScreen(),
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
            ),
          );
        },
      ),
    );
  }
}
