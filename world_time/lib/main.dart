import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/themeNotifier.dart';
import 'package:world_time/widgets/homeWidget.dart';
import 'package:world_time/pages/monitorVehicle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:world_time/firebase_options.dart';
import 'package:world_time/pages/settings.dart';
import 'package:world_time/pages/info.dart';
import 'package:world_time/pages/vehicleSettings.dart';
import 'package:world_time/pages/flowSettings.dart';
import 'package:world_time/pages/fieldBorders.dart';
import 'package:world_time/pages/manuelControl.dart';

// TODO: fix the bug related with repeated opening | closing action of boomArm button!

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebase();

  runApp(createApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Widget createApp() {
  return MultiProvider(
      providers: [
        ChangeNotifierProvider<LineUpdater>(create: (_) => LineUpdater()),
        ChangeNotifierProvider<LanguageUpdater>(create: (_) => LanguageUpdater()),
        ChangeNotifierProvider<TimeNotifier>(create: (_) => TimeNotifier()),
        ChangeNotifierProvider<MainMenuUpdater>(create: (_) => MainMenuUpdater()),
        ChangeNotifierProvider<PowerButtonOpacity>(create: (_) => PowerButtonOpacity()),
        ChangeNotifierProvider<ThemeSelector>(create: (_) => ThemeSelector()),
        ChangeNotifierProvider<ModelNotifier>(create: (_) => ModelNotifier()),
        ChangeNotifierProvider<ExpansionNotifier>(create: (_) => ExpansionNotifier()),
        ChangeNotifierProvider<BoomArmNotifier>(create: (_) => BoomArmNotifier()),
        ChangeNotifierProvider<RobbyNotifier>(create: (_) => RobbyNotifier()),
        ChangeNotifierProvider<ConnectivityNotifier>(create: (_) => ConnectivityNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/': (context) => const ChooseLocation(),
          '/home': (context) => const OpeningHome(),
          '/MainHome': (context) => const Home(),
          '/MonitorVehicle': (context) => const MonitorVehicle(),
          '/Settings' : (context) => const Settings(),
          '/Info' : (context) => const Info(),
          '/VehicleSettings' : (context) => const VehicleSettings(),
          '/FlowSettings' : (context) => const FlowSettings(),
          '/FieldBorders' : (context) => const FieldBorders(),
          '/ManuelControl' : (context) => const ManuelControl(),
        },
      )
  );
}
