import 'package:flutter/material.dart';
import 'dart:async';
import 'package:world_time/notifier_classes.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:world_time/themeNotifier.dart';


class TimeUpdater extends StatefulWidget {
  const TimeUpdater({Key? key}) : super(key: key);

  @override
  State<TimeUpdater> createState() => _TimeUpdaterState();
}

class _TimeUpdaterState extends State<TimeUpdater> {
  Timer? timer;
  bool tickLock = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void checkConnectivity(ConnectivityNotifier connectivityNotifier, ThemeSelector themeSelector, int tick) async{
    if (tick % 5 == 0){ // For every 5 seconds
      if(!tickLock){
        tickLock = true;
        try{
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty){
            connectivityNotifier.isConnected2Net = true;
            themeSelector.homeWifiStatusColor = Colors.green[400]!;
          }
        } on SocketException catch (_) {
          connectivityNotifier.isConnected2Net = false;
          themeSelector.homeWifiStatusColor = Colors.red[400]!;
        }
      }
    }
    else if (tickLock){
      tickLock = false;
    }
  }

  void startTimer(TimeNotifier timeNotifier, ConnectivityNotifier connectivityNotifier, ThemeSelector themeSelector) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        checkConnectivity(connectivityNotifier, themeSelector, timer.tick);
        String hour = DateTime.now().hour.toString();
        if (DateTime.now().hour.toString().length < 2) {
          hour = "0${DateTime.now().hour}";
        }
        String minute = DateTime.now().minute.toString();
        if (DateTime.now().minute.toString().length < 2) {
          minute = "0${DateTime.now().minute}";
        }
        String newTimeValue = "$hour:$minute";
        if (newTimeValue != timeNotifier.current_time) {
          timeNotifier.current_time = newTimeValue;
        }
    });
  }

  void stopTimer(LineUpdater state) {
    state.isTimerActive = false;
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeState = Provider.of<TimeNotifier>(context);
    final connectivityNotifier = Provider.of<ConnectivityNotifier>(context);
    final themeSelector = Provider.of<ThemeSelector>(context);

    startTimer(timeState, connectivityNotifier, themeSelector);
    return Consumer<TimeNotifier>(
      builder: (context, timeNotifier, _) => Text(
        timeNotifier.current_time,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 4,
        ),
      ),
    );
  }
}
