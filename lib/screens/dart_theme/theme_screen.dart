import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_state_management/theme_provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark =
            Theme.of(context).brightness ==
            Brightness
                .dark; // isDark will be true only if the Brightness.dark is there in the theme context.
        return Scaffold(
          appBar: AppBar(
            title: Text("Theme Screen (with shared prefs)"),
            actions: [
              IconButton(
                onPressed: () => _showThemeDialog(context),
                icon: Icon(
                  themeProvider.isSystemMode
                      ? Icons.auto_mode
                      : isDark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildWelcomeCard(context, isDark, themeProvider)],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeCard(
    BuildContext context,
    bool isDark,
    ThemeProvider themeProvider,
  ) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to ${themeProvider.currentThemeDescription}!',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              'Your theme prefernece is automatically saved.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose theme'),
          content: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<ThemeMode>(
                    title: Text('System Theme'),
                    subtitle: Text('Follow device settings'),
                    value: ThemeMode.system,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
