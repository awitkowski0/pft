import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'ui/pages/dashboard_page.dart';
import 'ui/pages/workout_page.dart';
import 'ui/pages/journal_page.dart';
import 'ui/pages/progress_page.dart';
import 'ui/pages/settings_page.dart';

PageRoute _buildRoute(Widget page, RouteSettings settings,
    {bool noTransition = false}) {
  if (noTransition) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => page,
      settings: settings,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
  return MaterialPageRoute(builder: (_) => page, settings: settings);
}

class PftPathApp extends StatelessWidget {
  const PftPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PFT Path',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _buildRoute(const DashboardPage(), settings,
                noTransition: true);
          case '/workout':
            return _buildRoute(const WorkoutPage(), settings);
          case '/journal':
            return _buildRoute(const JournalPage(), settings,
                noTransition: true);
          case '/progress':
            return _buildRoute(const ProgressPage(), settings);
          case '/settings':
            return _buildRoute(const SettingsPage(), settings,
                noTransition: true);
          default:
            return _buildRoute(const DashboardPage(), settings,
                noTransition: true);
        }
      },
    );
  }
}
