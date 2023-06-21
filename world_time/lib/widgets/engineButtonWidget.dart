import 'package:flutter/material.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/themeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:world_time/widgets/customPainterWidget.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'dart:math';
import 'package:world_time/firebase/firebaseDBConnection.dart';

class UpdatedPaint extends StatelessWidget {
  const UpdatedPaint({Key? key}) : super(key: key);

  final double central_dy = 294.0;
  final double distancer = 70.0;
  final double central_dx = 350.0;
  final double distancer_dx = 75.0;

  final double lineEndDy1 = 78;
  final double lineEndDy2 = 186;
  final double lineEndDy3 = 294;
  final double lineEndDy4 = 403;
  final double lineEndDy5 = 512;

  final double mini_circle_radius = 20;

  final double virtual_divider = 6.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<LineUpdater>(
        builder: (context, state, _) => Consumer<ThemeSelector>(
          builder: (context, themeSelector, _) => Stack(children: <Widget>[
            Opacity(
              opacity: (state.stateManagementIncrementer / 200),
              child: CustomPaint(
                  size:
                  Size(mini_circle_radius * 2, mini_circle_radius * 2),
                  painter: CirclePainter(2, central_dx, central_dy - distancer * 2 - (mini_circle_radius + mini_circle_radius * sin(atan2(lineEndDy1 - central_dy + distancer * 2, distancer_dx))),
                      themeSelector,
                      themeSelector
                          .homeManuelDriveIcon)
              ),
            ),
            CustomPaint(
                size: const Size(300, 300),
                painter: MyPainter(
                    state.stateManagementIncrementer,
                    Offset((central_dx + mini_circle_radius + mini_circle_radius * cos(atan2(lineEndDy1 - central_dy + distancer * 2, distancer_dx))), central_dy - distancer * 2),
                    Offset(central_dx + distancer_dx, lineEndDy1),
                    true,
                    0,
                    themeSelector)),
            Opacity(
              opacity: (state.stateManagementIncrementer / 200),
              child: CustomPaint(
                  size:
                  Size(mini_circle_radius * 2, mini_circle_radius * 2),
                  painter: CirclePainter(2, central_dx, central_dy - distancer - (mini_circle_radius + mini_circle_radius * sin(atan2(lineEndDy2 - central_dy + distancer, distancer_dx))),
                      themeSelector,
                      themeSelector.homeVehicleMonitorIcon)),
            ),
            CustomPaint(
                size: const Size(300, 300),
                painter: MyPainter(
                    state.stateManagementIncrementer,
                    Offset(central_dx + (mini_circle_radius + mini_circle_radius * cos(atan2(lineEndDy2 - central_dy + distancer, distancer_dx))), central_dy - distancer),
                    Offset(central_dx + distancer_dx, lineEndDy2),
                    true,
                    0,
                    themeSelector)),
            Opacity(
              opacity: (state.stateManagementIncrementer / 200),
              child: CustomPaint(
                  size:
                  Size(mini_circle_radius * 2, mini_circle_radius * 2),
                  painter: CirclePainter(2, central_dx, central_dy - (mini_circle_radius + mini_circle_radius * sin(atan2(lineEndDy3 - central_dy, distancer_dx))),
                      themeSelector,
                      themeSelector.homeHeadlightIcon)),
            ),
            CustomPaint(
                size: const Size(300, 300),
                painter: MyPainter(
                    state.stateManagementIncrementer,
                    Offset(central_dx + (mini_circle_radius + mini_circle_radius * cos(atan2(lineEndDy3 - central_dy, distancer_dx))), central_dy),
                    Offset(central_dx + distancer_dx, lineEndDy3),
                    true,
                    0,
                    themeSelector)),
            Opacity(
              opacity: (state.stateManagementIncrementer / 200),
              child: CustomPaint(
                  size:
                  Size(mini_circle_radius * 2, mini_circle_radius * 2),
                  painter: CirclePainter(2, central_dx,central_dy + distancer - (mini_circle_radius + mini_circle_radius * sin(atan2(lineEndDy4 - central_dy - distancer, distancer_dx))),
                      themeSelector,
                      themeSelector.homeBoomArmIcon)),
            ),
            CustomPaint(
                size: const Size(300, 300),
                painter: MyPainter(
                    state.stateManagementIncrementer,
                    Offset(central_dx +(mini_circle_radius + mini_circle_radius *cos(atan2(lineEndDy4 - central_dy - distancer,distancer_dx))), central_dy + distancer),
                    Offset(central_dx + distancer_dx, lineEndDy4),
                    true,
                    0,
                    themeSelector)),
            Opacity(
              opacity: (state.stateManagementIncrementer / 200),
              child: CustomPaint(
                  size:
                  Size(mini_circle_radius * 2, mini_circle_radius * 2),
                  painter: CirclePainter(2, central_dx, central_dy + distancer * 2 - (mini_circle_radius + mini_circle_radius * sin(atan2(lineEndDy5 - central_dy - distancer * 2, distancer_dx))),
                      themeSelector,
                      themeSelector.homeExpansionIcon)),
            ),
            CustomPaint(
                size: const Size(300, 300),
                painter: MyPainter(
                    state.stateManagementIncrementer,
                    Offset(central_dx + (mini_circle_radius + mini_circle_radius * cos(atan2(lineEndDy5 - central_dy -distancer * 2, distancer_dx))), central_dy + distancer * 2), Offset(central_dx + distancer_dx, lineEndDy5),
                    true,
                    0,
                    themeSelector)),
          ]),
        ));
  }
}

class EngineButton extends StatefulWidget {
  const EngineButton({Key? key}) : super(key: key);

  @override
  State<EngineButton> createState() => _EngineButtonState();
}

class _EngineButtonState extends State<EngineButton> with TickerProviderStateMixin {
  Color? emergencyColor = Colors.red[800];
  Color? autonomousColor = Colors.green[600];
  Color? activeColor = Colors.green[600];

  Text? emergencyText;
  Text? autonomousText;
  Text? activeText;

  AnimationController? animationController;
  Animation<double>? animation;

  AnimationController? expansionAnimationController;
  Animation<double>? expansionAnimation;

  LineUpdater state = LineUpdater();

  @override
  void initState() {
    super.initState();

    emergencyText = const Text("EMERGENCY STOP",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ));

    autonomousText = const Text("START AUTONOMOUS",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ));
    activeText = autonomousText;

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation =
    CurvedAnimation(parent: animationController!, curve: Curves.ease)
      ..addListener(() {
        final stateIncrement =
        Provider.of<LineUpdater>(context, listen: false);
        stateIncrement.stateManagementIncrementer =
        (animationController!.value * 200);
        //print(animationController!.value);
        if (animationController!.value == 1.0 && stateIncrement.isOpened == false) {
          stateIncrement.isOpened = true;
          stopAnimation(stateIncrement);
        }
        if (animationController!.value == 0.0 && stateIncrement.isOpened == true) {
          stateIncrement.isOpened = false;
          stopAnimation(stateIncrement);
        }
      });

    expansionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    expansionAnimation =
    CurvedAnimation(parent: expansionAnimationController!, curve: Curves.ease)
      ..addListener( () {
        final expansionNotifier = Provider.of<ExpansionNotifier>(context, listen: false);
        final stateIncrement = Provider.of<LineUpdater>(context, listen: false);
        expansionNotifier.counter = (expansionAnimationController!.value * 100);
        if (expansionAnimationController!.value == 1.0 && !expansionNotifier.isExpansionMenuOpened){
          expansionNotifier.isExpansionMenuOpened = true;
          stopExpansionAnimation(expansionNotifier);
        }
        if (expansionAnimationController!.value == 0.0 && expansionNotifier.isExpansionMenuOpened){
          expansionNotifier.isExpansionMenuOpened = false;
          startAnimation(stateIncrement);
          stopExpansionAnimation(expansionNotifier);
        }
      }
      );

    Future.delayed(const Duration(seconds: 2), () {
      startAnimation(state);
    });
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
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer6<ThemeSelector, ModelNotifier, LineUpdater, ExpansionNotifier, BoomArmNotifier, ConnectivityNotifier>(
        builder: (context, themeSelector, modelNotifier, stateIncrement, expansionNotifier, boomArmNotifier, connectivityNotifier,_) =>
            Stack(
              alignment: Alignment.center,
              children: <Widget> [
                CustomPaint(
                  size: const Size(227,0),
                  painter: DashedLinePainter(const Offset(0,-115), 100,expansionNotifier, themeSelector),
                ),
                CustomPaint(
                  size: const Size(0,0),
                  painter: SideWayDashedLinePainter(const Offset(150 ,-270), 100, 100 ,expansionNotifier, themeSelector),
                ),
                expansionNotifier.isExpansionMenuOpened ?
                Opacity(
                  opacity: (expansionNotifier.counter / 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      SizedBox(
                          width: 130,
                          height: 50,
                          child: FlutterSlider(
                              values: [100 - expansionNotifier.trackLength],
                              axis: Axis.horizontal,
                              trackBar: FlutterSliderTrackBar(
                                inactiveTrackBar: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: themeSelector.homeConnectionStatusColor,
                                  border: Border.all(width: 3, color: themeSelector.homeConnectionStatusColor),
                                ),
                                activeTrackBar: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: themeSelector.homeExpansionSliderMainColor,
                                ),
                              ),
                              handler: FlutterSliderHandler(
                                decoration: const BoxDecoration(),
                                child: Icon(Icons.vertical_align_center, color: themeSelector.homeExpansionSliderMainColor,),
                              ),
                              tooltip: FlutterSliderTooltip(
                                  format: (String value) {
                                    return (100 - double.parse(value)).toString();
                                  },
                                  boxStyle: const FlutterSliderTooltipBox(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  textStyle: TextStyle(color: themeSelector.homeTopLineColor, fontWeight: FontWeight.bold, fontSize: 12,),
                                  positionOffset: FlutterSliderTooltipPositionOffset(
                                    top: -12,
                                  ),
                                  alwaysShowTooltip: true,
                              ),
                              max: 100,
                              min: 0,
                              onDragging: (handlerIndex, lowerValue, upperValue){
                                expansionNotifier.trackLength = 100.0 -  lowerValue;
                              }
                          )
                      ),
                      SizedBox(
                          width: 120,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget> [
                              CustomPaint(
                                size: const Size(50,120),
                                painter: CloseButtonLinePainter(const Offset(-50,30), const Offset(-30,12), 110, true, themeSelector),
                              ),
                              CustomPaint(
                                size: const Size(50,120),
                                painter: CloseButtonLinePainter(const Offset(100,30), const Offset(80,48), 110, false, themeSelector),
                              ),
                              CustomPaint(
                                size: const Size(240,240),
                                painter: ArrowPainter(450, 240, true, themeSelector),
                              ),
                              CustomPaint(
                                size: const Size(240,240),
                                painter: ArrowPainter(180, 240, false, themeSelector),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  expansionDBUpdate(expansionNotifier.trackLength, expansionNotifier.escalation, connectivityNotifier.isConnected2Net);
                                  expansionNotifier.isTriggered = false;
                                  startExpansionAnimation(expansionNotifier);
                                  modelNotifier.isModelLocked = false;
                                  modelNotifier.orientation = '0deg 90deg auto';
                                  modelNotifier.controller.runJavascript(
                                      """setModel("${modelNotifier.orientation}",${modelNotifier.isModelLocked.toString()})""");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  foregroundColor: Colors.black,
                                ),

                                child: Text(
                                  "CONFIRM",
                                  style: TextStyle(
                                      color: themeSelector.homeMenuButtonMainColor,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      shadows: <Shadow> [Shadow(blurRadius: 2, color: themeSelector.homeMenuButtonMainColor)]
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(
                          width: 130,
                          height: 50,
                          child: FlutterSlider(
                              values: [expansionNotifier.trackLength],
                              axis: Axis.horizontal,
                              trackBar: FlutterSliderTrackBar(
                                inactiveTrackBar: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: themeSelector.homeExpansionSliderMainColor,
                                  border: Border.all(width: 3, color: themeSelector.homeExpansionSliderMainColor),
                                ),
                                activeTrackBar: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: themeSelector.homeConnectionStatusColor,
                                ),
                              ),
                              handler: FlutterSliderHandler(
                                decoration: const BoxDecoration(),
                                child: Icon(Icons.vertical_align_center, color: themeSelector.homeExpansionSliderMainColor  ,),
                              ),
                              tooltip: FlutterSliderTooltip(
                                  boxStyle: const FlutterSliderTooltipBox(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  textStyle: TextStyle(color: themeSelector.homeTopLineColor, fontWeight: FontWeight.bold, fontSize: 12,),
                                  positionOffset: FlutterSliderTooltipPositionOffset(
                                    top: -12,
                                  ),
                                  alwaysShowTooltip: true,
                              ),
                              max: 100,
                              min: 0,
                              onDragging: (handlerIndex, lowerValue, upperValue){
                                expansionNotifier.trackLength = lowerValue;
                              }
                          )
                      ),
                    ],
                  ),
                ) : Container(),
                boomArmNotifier.counter != 100 && stateIncrement.stateManagementIncrementer != 0 ?
                Opacity(
                  opacity: (stateIncrement.stateManagementIncrementer >= 100 ? (( stateIncrement.stateManagementIncrementer - 100) / 100) * (100 - boomArmNotifier.counter) / 100 : 0.0 ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (!stateIncrement.isTimerActive) {
                        //stateIncrement.stateManagementIncrementer = 0;
                        //startAnimation(stateIncrement);
                        setState(() {
                          if (activeText == emergencyText) {
                            activeText = autonomousText;
                            activeColor = themeSelector.homeBottomButtonAutonomous;
                          } else {
                            activeText = emergencyText;
                            activeColor = themeSelector.homeBottomButtonEmergency;
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: activeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        minimumSize: const Size(274, 100)),
                    child: activeText,
                  ),
                )
                    :
                Container(width: 500, height: 100,),
              ],
            )
    );
  }
}
