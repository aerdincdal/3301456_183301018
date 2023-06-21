import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/themeNotifier.dart';

class TriggerExpansion extends StatefulWidget {
  const TriggerExpansion({Key? key}) : super(key: key);

  @override
  State<TriggerExpansion> createState() => _TriggerExpansionState();
}

class _TriggerExpansionState extends State<TriggerExpansion> with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  AnimationController? expansionAnimationController;
  Animation<double>? expansionAnimation;

  AnimationController? boomArmAnimationController;
  Animation<double>? boomArmAnimation;

  LineUpdater state = LineUpdater();

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation =
    CurvedAnimation(parent: animationController!, curve: Curves.linear)
      ..addListener(() {
        final stateIncrement = Provider.of<LineUpdater>(context, listen: false);
        stateIncrement.stateManagementIncrementer =
        (animationController!.value * 200);
        //print(animationController!.value);
        if (animationController!.value == 1.0 &&
            stateIncrement.isOpened == true) {
          stopAnimation(stateIncrement);
        }
        if (animationController!.value == 0.0 &&
            stateIncrement.isOpened == false) {
          stopAnimation(stateIncrement);
        }
      }
      );

    expansionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    expansionAnimation =
    CurvedAnimation(parent: expansionAnimationController!, curve: Curves.ease)
      ..addListener( () {
        final expansionNotifier = Provider.of<ExpansionNotifier>(context, listen: false);
        expansionNotifier.counter = (expansionAnimationController!.value * 100);
        if (expansionAnimationController!.value == 1.0 && !expansionNotifier.isExpansionMenuOpened){
          expansionNotifier.isExpansionMenuOpened = true;
          stopExpansionAnimation(expansionNotifier);
        }
        if (expansionAnimationController!.value == 0.0 && expansionNotifier.isExpansionMenuOpened){
          expansionNotifier.isExpansionMenuOpened = false;
          stopExpansionAnimation(expansionNotifier);
        }
      }
      );

    boomArmAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    boomArmAnimation =
    CurvedAnimation(parent: boomArmAnimationController!, curve: Curves.ease)
      ..addListener( () {
        final boomArmNotifier = Provider.of<BoomArmNotifier>(context, listen: false);
        boomArmNotifier.counter = (boomArmAnimationController!.value * 100);
        if (boomArmAnimationController!.value == 1.0 && !boomArmNotifier.isBoomArmMenuOpened){
          boomArmNotifier.isBoomArmMenuOpened = true;
          stopBoomArmAnimation(boomArmNotifier);
        }
        if (boomArmAnimationController!.value == 0.0 && boomArmNotifier.isBoomArmMenuOpened){
          boomArmNotifier.isBoomArmMenuOpened = false;
          stopBoomArmAnimation(boomArmNotifier);
        }
      }
    );
  }

  void startBoomArmAnimation(BoomArmNotifier boomArmNotifier){
    if (!boomArmNotifier.isBoomArmMenuOpened){
      boomArmAnimationController?.forward(from: 0);
    } else {
      boomArmAnimationController?.reverse(from: 1);
    }
  }

  void stopBoomArmAnimation(BoomArmNotifier boomArmNotifier){
    boomArmAnimationController?.stop();
  }

  void startExpansionAnimation(ExpansionNotifier expansionNotifier){
    expansionNotifier.isExpansionMenuOpening = true;
    if (!expansionNotifier.isExpansionMenuOpened){
      expansionAnimationController?.forward(from: 0);
    } else {
      expansionAnimationController?.reverse(from: 1);
    }
  }

  void stopExpansionAnimation(ExpansionNotifier expansionNotifier){
    expansionNotifier.isExpansionMenuOpening = false;
    expansionAnimationController?.stop();
  }

  void startAnimation(LineUpdater state) {
    state.isTimerActive = true;
    if (!state.isOpened) {
      animationController?.forward(from: 0);
    } else {
      animationController?.reverse(from: 1);
    }
  }

  void stopAnimation(LineUpdater state) {
    state.isTimerActive = false;
    animationController?.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeSelector, LineUpdater>(
      builder: (context, themeSelector, lineUpdater, _) =>
      lineUpdater.stateManagementIncrementer > 150
          ? Opacity(
        opacity: lineUpdater.stateManagementIncrementer > 150
            ? ((lineUpdater.stateManagementIncrementer - 150) / 50)
            : 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(86, 44, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/ManuelControl');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  "MANUEL CONTROL",
                  style: TextStyle(
                    fontSize: 13,
                    color: themeSelector.homeMenuSubButtonColor,
                    shadows: const <Shadow>[
                      Shadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(0, 17)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 61),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushNamed('/MonitorVehicle');
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  "MONITOR VEHICLE",
                  style: TextStyle(
                    fontSize: 13,
                    color: themeSelector.homeMenuSubButtonColor,
                    shadows: const <Shadow>[
                      Shadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(0, 17)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 61),
              GestureDetector(
                onLongPress: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Opens & Closes headlights"),
                    ),
                  );
                },
                child: ElevatedButton(
                  onPressed: () {
                    themeSelector.isHeadlightOn =
                    !themeSelector.isHeadlightOn;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "HEADLIGHTS I/O",
                    style: TextStyle(
                      fontSize: 13,
                      color: themeSelector.homeMenuSubButtonColor,
                      shadows: const <Shadow>[
                        Shadow(
                            color: Colors.black,
                            blurRadius: 10.0,
                            offset: Offset(0, 17)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 61),
              Consumer3<ModelNotifier, BoomArmNotifier, LineUpdater>(
                builder: (context, modelNotifier, boomArmNotifier, lineUpdater, _) =>
                ElevatedButton(
                  onPressed: () {
                    modelNotifier.isModelLocked = true;
                    modelNotifier.orientation = '30deg 75deg auto';
                    modelNotifier.controller.runJavascript(
                        """setModel("${modelNotifier.orientation}",${modelNotifier.isModelLocked.toString()})""");
                    boomArmNotifier.isTriggered = true;
                    startAnimation(lineUpdater);
                    lineUpdater.isOpened = !lineUpdater.isOpened;
                    startBoomArmAnimation(boomArmNotifier);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "BOOM ARM",
                    style: TextStyle(
                      fontSize: 13,
                      color: themeSelector.homeMenuSubButtonColor,
                      shadows: const <Shadow>[
                        Shadow(
                            color: Colors.black,
                            blurRadius: 10.0,
                            offset: Offset(0, 17)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 61),
              Consumer3<ModelNotifier, LineUpdater, ExpansionNotifier>(
                builder: (context, modelNotifier, lineUpdater, expansionNotifier, _) =>
                    ElevatedButton(
                      onPressed: () {
                        modelNotifier.isModelLocked = true;
                        modelNotifier.orientation = '0deg 90deg auto';
                        modelNotifier.controller.runJavascript(
                            """setModel("${modelNotifier.orientation}",${modelNotifier.isModelLocked.toString()})""");
                        expansionNotifier.isTriggered = true;
                        startAnimation(lineUpdater);
                        lineUpdater.isOpened = !lineUpdater.isOpened;
                        startExpansionAnimation(expansionNotifier);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        "EXPANSION",
                        style: TextStyle(
                          fontSize: 13,
                          color: themeSelector.homeMenuSubButtonColor,
                          shadows: const <Shadow>[
                            Shadow(
                                color: Colors.black,
                                blurRadius: 10.0,
                                offset: Offset(0, 17)),
                          ],
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      )
          : Container(),
    );
  }
}
