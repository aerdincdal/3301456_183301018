import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/firebase/firebaseDBConnection.dart';

class PowerOpacityTrigger extends StatefulWidget {
  const PowerOpacityTrigger({Key? key}) : super(key: key);

  @override
  State<PowerOpacityTrigger> createState() => _PowerOpacityTriggerState();
}

class _PowerOpacityTriggerState extends State<PowerOpacityTrigger> {
  Timer? timer;
  bool lockButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void startTimer(PowerButtonOpacity powerOpacity, LineUpdater state, ConnectivityNotifier connectivityNotifier) {
    timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        if (timer.tick < 120 && powerOpacity.opacity < 100) {
          powerOpacity.opacity++;
        } else if (powerOpacity.opacity == 0 &&
             powerOpacity.generalOpacity == 0) {
          onAppStartDBUpdate(connectivityNotifier.isConnected2Net);
          Navigator.of(context).pushNamed('/MainHome');
          stopTimer(state);
        } else {
          if (powerOpacity.opacity != powerOpacity.generalOpacity) {
            powerOpacity.generalOpacity = powerOpacity.opacity;
          }
          powerOpacity.opacity--;
          powerOpacity.generalOpacity--;
        }
      });
    });
  }

  void stopTimer(LineUpdater state) {
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<PowerButtonOpacity, LineUpdater, ConnectivityNotifier>(
      builder: (context, opacityState, state, connectivityNotifier,_) => ElevatedButton(
        onPressed: () {
          if (!lockButton) {
            startTimer(opacityState, state, connectivityNotifier);
            lockButton = true;
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.grey[900],
          enableFeedback: true,
        ),
        child: const SizedBox(
          width: 88,
          height: 120,
        ),
      ),
    );
  }
}

class PowerOpacity extends StatelessWidget {
  const PowerOpacity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PowerButtonOpacity>(
      builder: (context, opacityState, _) => Stack(children: <Widget>[
        Opacity(
          opacity: (1 - opacityState.opacity / 100) *
              (opacityState.generalOpacity / 100),
          child: Image(
            image: const AssetImage("assets/powerButtonO.png"),
            filterQuality: FilterQuality.high,
            width: 120,
            color: Colors.grey[100],
          ),
        ),
        Opacity(
          opacity: (opacityState.opacity / 100) *
              (opacityState.generalOpacity / 100),
          child: Image(
            image: const AssetImage("assets/powerButtonI.png"),
            filterQuality: FilterQuality.high,
            width: 120,
            color: Colors.grey[100],
          ),
        ),
      ]),
    );
  }
}
