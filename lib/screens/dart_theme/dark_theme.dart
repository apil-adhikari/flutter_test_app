import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_state_management/theme_changer_provider.dart';

class DarkTheme extends StatefulWidget {
  const DarkTheme({super.key});

  @override
  State<DarkTheme> createState() => _DarkThemeState();
}

class _DarkThemeState extends State<DarkTheme> {
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeChangerProvider>(context);
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Changer'),
        elevation: 1,
        actions: [
          Consumer<ThemeChangerProvider>(
            builder: (context, themeProviderValue, child) => Icon(
              themeProviderValue.currentTheme == ThemeMode.light
                  ? Icons.wb_sunny_outlined
                  : themeProviderValue.currentTheme == ThemeMode.dark
                  ? Icons.sunny
                  : Icons.autofps_select_rounded,
            ),
          ),
        ],
        actionsPadding: EdgeInsets.all(20),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Consumer<ThemeChangerProvider>(
              builder: (context, themeProviderValue, child) => Row(
                children: [
                  Text(
                    "Use system Theme ?",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  CupertinoSwitch(
                    value: themeProviderValue.systemTheme,
                    onChanged: (newValue) {
                      // print(newValue);
                      // themeProviderValue.setTheme(
                      //   newValue ? ThemeMode.system : ThemeMode.light,
                      // );
                      newValue
                          ? themeProviderValue.useSystemTheme()
                          : themeProviderValue.useLightTheme();
                    },
                  ),
                ],
              ),
            ),

            Consumer<ThemeChangerProvider>(
              builder: (context, themeProviderValue, child) => SizedBox(
                child: themeProviderValue.systemTheme
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).hoverColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Text('Toggle Theme'),
                            Spacer(),
                            CupertinoSwitch(
                              value:
                                  themeProviderValue.currentTheme ==
                                      ThemeMode.light
                                  ? false
                                  : true,
                              onChanged: (newValue) {
                                newValue
                                    ? themeProviderValue.useDarkTheme()
                                    : themeProviderValue.useLightTheme();
                              },
                            ),
                          ],
                        ),
                      ),
              ),
            ),

            // Consumer<ThemeChangerProvider>(
            //   builder: (context, themeProviderValue, child) => Row(
            //     children: [
            //       Text('Toggle Theme'),
            //       Spacer(),
            //       CupertinoSwitch(
            //         value: themeProviderValue.currentTheme == ThemeMode.light
            //             ? false
            //             : true,
            //         onChanged: (newValue) {
            //           newValue
            //               ? themeProviderValue.toggleLightDark(ThemeMode.dark)
            //               : themeProviderValue.toggleLightDark(ThemeMode.light);
            //         },
            //       ),
            //     ],
            //   ),
            // ),

            // Consumer<ThemeChangerProvider>(
            //   builder: (context, themeProviderValue, child) =>
            //       themeProviderValue.currentTheme == ThemeMode.light &&
            //       Text('hello'),
            // ),

            // themeProvider.systemTheme
            //     ? Container(
            //         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            //         decoration: BoxDecoration(
            //           color: Colors.green,
            //           borderRadius: BorderRadius.circular(25),
            //         ),

            //         child: Text(
            //           'Using System Theme',
            //           style: TextStyle(fontSize: 12, color: Colors.white),
            //         ),
            //       )
            //     : Row(
            //         children: <Widget>[
            //           Text(
            //             themeProvider.currentTheme == ThemeMode.light
            //                 ? 'Light Theme'
            //                 : 'Dark Theme',
            //             style: Theme.of(context).textTheme.titleMedium
            //                 ?.copyWith(color: Theme.of(context).primaryColor),
            //           ),
            //           Spacer(),
            //           CupertinoSwitch(
            //             // title: Text("Light/Dark Theme"),
            //             value: themeProvider.currentTheme == ThemeMode.light
            //                 ? false
            //                 : true,
            //             onChanged: (newValue) {
            //               newValue
            //                   ? themeProvider.toggleTheme(ThemeMode.dark)
            //                   : themeProvider.toggleTheme(ThemeMode.light);
            //             },
            //           ),
            //         ],
            //       ),
          ],
        ),
      ),
    );
  }
}


/* 
[
          RadioListTile<ThemeMode>(
            title: Text('light mode'),
            value: ThemeMode.light,
            groupValue: themeProvider.currentTheme,
            onChanged: themeProvider.toggleTheme,
          ),
          RadioListTile<ThemeMode>(
            title: Text('dark mode'),
            value: ThemeMode.dark,
            groupValue: themeProvider.currentTheme,
            onChanged: themeProvider.toggleTheme,
          ),
          RadioListTile<ThemeMode>(
            title: Text('system mode'),
            value: ThemeMode.system,
            groupValue: themeProvider.currentTheme,
            onChanged: themeProvider.toggleTheme,
          ),
        ],
      ),
*/