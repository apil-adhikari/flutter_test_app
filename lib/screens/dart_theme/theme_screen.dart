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
                      : (isDark ? Icons.dark_mode : Icons.light_mode),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeCard(context, isDark, themeProvider),
                SizedBox(height: 24),
                _buildThemeInfoCard(context, isDark, themeProvider),
                SizedBox(height: 24),
                Text(
                  'Sample UI Elements',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                _buildSampleUiElements(context),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            child: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
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
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      themeProvider.setThemeMode(value!);
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text('Light Mode'),
                    subtitle: Text('Change to light mode'),
                    value: ThemeMode.light,
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      themeProvider.setThemeMode(value!);
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text('Dark Mode'),
                    subtitle: Text('Change to dark mode'),
                    value: ThemeMode.dark,
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      themeProvider.setThemeMode(value!);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancle'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeInfoCard(
    BuildContext context,
    bool isDark,
    ThemeProvider themeProvider,
  ) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.palette_rounded),
              title: Text('CurrentTheme'),
              subtitle: Text(themeProvider.currentThemeDescription),
              trailing: Icon(
                themeProvider.isSystemMode
                    ? Icons.auto_mode
                    : themeProvider.isLightMode
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: themeProvider.setLightMode,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode),
                ),
                TextButton.icon(
                  onPressed: themeProvider.setDarkMode,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode),
                ),
                TextButton.icon(
                  onPressed: themeProvider.setSystemMode,
                  label: Text('System'),
                  icon: Icon(Icons.auto_mode),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSampleUiElements(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Sample Input',
                prefixIcon: Icon(Icons.edit_rounded),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Elevated'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('Outlined'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Text Button'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.abc_rounded),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ...List.generate(
              3,
              (index) => ListTile(
                style: Theme.of(context).listTileTheme.copyWith(

                ),
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text('List Item ${index + 1}'),
                subtitle: Text('This is sample subtitle.'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
