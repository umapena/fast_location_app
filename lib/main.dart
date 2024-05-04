import 'package:fast_location_app/src/modules/history/page/history_page.dart';
import 'package:fast_location_app/src/modules/initial/page/initial_page.dart';
import 'package:fast_location_app/src/modules/home/page/home_page.dart';
import 'package:fast_location_app/src/routes/app_router.dart';
import 'package:fast_location_app/src/shared/storage/hive_config.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveConfig.initHiveDatabase();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Location',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const InitialPage(),
      routes: {
        AppRouter.home: (context) => const HomePage(),
        AppRouter.history: (context) => const HistoryPage(),
      },
    );
  }
}
