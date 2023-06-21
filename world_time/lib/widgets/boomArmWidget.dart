import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/themeNotifier.dart';
import 'package:world_time/firebase/firebaseDBConnection.dart';


class boomArmMenu extends StatefulWidget {
  const boomArmMenu({Key? key}) : super(key: key);

  @override
  State<boomArmMenu> createState() => _boomArmMenuState();
}

class _boomArmMenuState extends State<boomArmMenu> with TickerProviderStateMixin{

  AnimationController? animationController;
  Animation<double>? animation;

  AnimationController? boomArmAnimationController;
  Animation<double>? boomArmAnimation;

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

    boomArmAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    boomArmAnimation =
    CurvedAnimation(parent: boomArmAnimationController!, curve: Curves.ease)
      ..addListener( () {
        final boomArmNotifier = Provider.of<BoomArmNotifier>(context, listen: false);
        final lineUpdater = Provider.of<LineUpdater>(context, listen: false);
        boomArmNotifier.counter = (boomArmAnimationController!.value * 100);
        if (boomArmAnimationController!.value == 1.0 && !boomArmNotifier.isBoomArmMenuOpened){
          boomArmNotifier.isBoomArmMenuOpened = true;
          stopBoomArmAnimation(boomArmNotifier);
        }
        if (boomArmAnimationController!.value == 0.0 && boomArmNotifier.isBoomArmMenuOpened){
          boomArmNotifier.isTriggered = false;
          boomArmNotifier.isBoomArmMenuOpened = false;
          startAnimation(lineUpdater);
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

  void startAnimation(LineUpdater state) {
    state.isTimerActive = true;
    if (!state.isOpened) {
      animationController?.forward(from: 0);
    } else {
      animationController?.reverse(from: 1);
    }
  }

  void stopAnimation(LineUpdater state) {
    state.isOpened = true;
    state.isTimerActive = false;
    animationController?.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<BoomArmNotifier, ThemeSelector, ModelNotifier, ConnectivityNotifier>(
        builder: (context, boomArmNotifier, themeSelector, modelNotifier, connectivityNotifier,_)  =>
        boomArmNotifier.isTriggered ?
        Opacity(
          opacity: (boomArmNotifier.counter / 100),
          child: Stack(
            children: <Widget> [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Consumer2<ThemeSelector, BoomArmNotifier>(
                    builder: (context, themeSelector, boomArmNotifier, _) =>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text("LEFT ARM", style: TextStyle(color: themeSelector.homeTopLineColor, letterSpacing: 2, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeTopLineColor,)]),),
                                SizedBox(width: 95, child: Divider(height: 1, color: themeSelector.homeTopLineColor, indent: 0, endIndent: 0,thickness:  2,)),
                                Text( boomArmNotifier.leftArmStatus == 0 ? "Closed" : (boomArmNotifier.leftArmStatus == 1 ? "Semi-Opened" : "Opened"),
                                  style: TextStyle(color: themeSelector.homeBoomArmSubMenuOuterCircleColor, letterSpacing: 2, shadows: <Shadow>[Shadow(blurRadius: 1, color: themeSelector.homeBoomArmSubMenuOuterCircleColor), ], ), ),
                              ],
                            ),
                            const SizedBox(width: 30,),
                            Column(
                              children: <Widget>[
                                Text("RIGHT ARM", style: TextStyle(color: themeSelector.homeTopLineColor, letterSpacing: 2, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeTopLineColor,)]),),
                                SizedBox(width: 95, child: Divider(height: 1, color: themeSelector.homeTopLineColor, indent: 0, endIndent: 0,thickness:  2,)),
                                Text( boomArmNotifier.rightArmStatus == 0 ? "Closed" : (boomArmNotifier.rightArmStatus == 1 ? "Semi-Opened" : "Opened"),
                                      style: TextStyle(color: themeSelector.homeBoomArmSubMenuOuterCircleColor, letterSpacing: 2, shadows: <Shadow>[Shadow(blurRadius: 1, color: themeSelector.homeBoomArmSubMenuOuterCircleColor,), ], ), ),
                              ],
                            ),
                          ],
                        ),
                    ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: 250,
                    height: 200,
                    child: FlutterSlider(
                      values: const [0],
                      axis: Axis.vertical,
                      min: 0,
                      max: 2,
                      minimumDistance: 0.1,
                      lockDistance: 0.1,
                      selectByTap: false,
                      step: const FlutterSliderStep(step: 0.1),
                      onDragging: (handlerIndex, lowerValue, upperValue){
                        if (boomArmNotifier.whichArm == -1){
                          boomArmNotifier.leftArmStatus = lowerValue;
                        }
                        else if (boomArmNotifier.whichArm == 1){
                          boomArmNotifier.rightArmStatus = lowerValue;
                        }
                        else {
                          boomArmNotifier.leftArmStatus = lowerValue;
                          boomArmNotifier.rightArmStatus = lowerValue;
                        }
                      },
                      trackBar: FlutterSliderTrackBar(
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: themeSelector.homeConnectionStatusColor,
                          boxShadow: <BoxShadow> [BoxShadow(color: themeSelector.homeConnectionStatusColor, blurRadius: 3,)],
                          border: Border.all(width: 50, color: themeSelector.homeConnectionStatusColor,),
                        ),
                        activeTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: themeSelector.homeConnectionStatusColor,
                        ),
                        activeDisabledTrackBarColor: Colors.transparent,
                      ),
                      handler: FlutterSliderHandler(
                        decoration: const BoxDecoration(),
                        child: Icon(Icons.circle, color: themeSelector.homeMenuSubButtonColor, shadows: <Shadow>[Shadow(color: themeSelector.homeMenuSubButtonColor, blurRadius: 3,)],),
                      ),
                      tooltip: FlutterSliderTooltip(
                        disabled: true,
                      ),
                      hatchMark: FlutterSliderHatchMark(
                          labels: <FlutterSliderHatchMarkLabel> [
                            /// 0 Percent
                            FlutterSliderHatchMarkLabel(
                              label: Container(color: themeSelector.homeGeneralBackgroundColor, child: Icon(Icons.circle_outlined, color: themeSelector.homeBoomArmSubMenuOuterCircleColor, size: 50, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeBoomArmSubMenuOuterCircleColor)], ),),
                              percent: 0.0,
                            ),
                            FlutterSliderHatchMarkLabel(
                              label: Container(width: 250, alignment: Alignment.centerLeft, child: Row(children: <Widget> [ Expanded(flex: 10, child: Align(alignment: Alignment.centerRight, child: Text("CLOSED", style: TextStyle(color: themeSelector.homeTopLineColor, letterSpacing: 2, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeTopLineColor,)]), ))), Expanded(flex: 16 , child: Container()) ],) ),
                              percent: 0.0,
                            ),
                            /// 50 Percent
                            FlutterSliderHatchMarkLabel(
                              label: Container(color: themeSelector.homeGeneralBackgroundColor, child: Icon(Icons.circle_outlined, color: themeSelector.homeBoomArmSubMenuOuterCircleColor, size: 50, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeBoomArmSubMenuOuterCircleColor)],)),
                              percent: 50.0,
                            ),
                            FlutterSliderHatchMarkLabel(
                              label: Container(width: 250, alignment: Alignment.centerLeft, child: Row(children: <Widget> [ Expanded(flex: 10, child: Align(alignment: Alignment.centerRight, child: Text("SEMI-OPEN", style: TextStyle(color: themeSelector.homeTopLineColor, letterSpacing: 2, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeTopLineColor,)]), ))), Expanded(flex: 16 , child: Container()) ],) ),
                              percent: 50.0,
                            ),
                            /// 100 Percent
                            FlutterSliderHatchMarkLabel(
                              label: Container(color: themeSelector.homeGeneralBackgroundColor, child: Icon(Icons.circle_outlined, color: themeSelector.homeBoomArmSubMenuOuterCircleColor, size: 50, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeBoomArmSubMenuOuterCircleColor)], ),),
                              percent: 100.0,
                            ),
                            FlutterSliderHatchMarkLabel(
                              label: Container(width: 250, alignment: Alignment.centerLeft, child: Row(children: <Widget> [ Expanded(flex: 10, child: Align(alignment: Alignment.centerRight, child: Text("OPEN", style: TextStyle(color: themeSelector.homeTopLineColor, letterSpacing: 2, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeTopLineColor,)]), ))), Expanded(flex: 16 , child: Container()) ],) ),
                              percent: 100.0,
                            ),
                          ]
                      ),
                      ignoreSteps: [FlutterSliderIgnoreSteps(from: 0.1, to: 0.9),
                        FlutterSliderIgnoreSteps(from: 1.1, to: 1.9),],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: 200,
                    height: 100,
                    child: FlutterSlider(
                      values: [(boomArmNotifier.whichArm + 1.0)],
                      axis: Axis.horizontal,
                      min: 0,
                      max: 2,
                      minimumDistance: 0.1,
                      lockDistance: 0.1,
                      selectByTap: false,
                      step: const FlutterSliderStep(step: 0.1),
                      onDragging: (handlerIndex, lowerValue, upperValue){
                        if (boomArmNotifier.whichArm != lowerValue - 1) {
                          boomArmNotifier.whichArm = (lowerValue - 1);
                        }
                      },
                      trackBar: FlutterSliderTrackBar(
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: themeSelector.homeConnectionStatusColor,
                          boxShadow: <BoxShadow> [BoxShadow(color: themeSelector.homeConnectionStatusColor, blurRadius: 3,)],
                          border: Border.all(width: 50, color: themeSelector.homeConnectionStatusColor,),
                        ),
                        activeTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: themeSelector.homeConnectionStatusColor,
                        ),
                        activeDisabledTrackBarColor: Colors.transparent,
                      ),
                      handler: FlutterSliderHandler(
                        decoration: const BoxDecoration(),
                        child: Icon(Icons.circle, color: themeSelector.homeMenuSubButtonColor, shadows: <Shadow>[Shadow(color: themeSelector.homeMenuSubButtonColor, blurRadius: 3,)],),
                      ),
                      tooltip: FlutterSliderTooltip(
                        disabled: true,
                      ),
                      hatchMark: FlutterSliderHatchMark(
                        labels: <FlutterSliderHatchMarkLabel> [
                          /// 0 Percent
                          FlutterSliderHatchMarkLabel(
                            label: Container(color: themeSelector.homeGeneralBackgroundColor, child: Icon(Icons.circle_outlined, color: themeSelector.homeBoomArmSubMenuOuterCircleColor, size: 50, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeBoomArmSubMenuOuterCircleColor)], ),),
                            percent: 0.0,
                          ),
                          FlutterSliderHatchMarkLabel(
                            label: Container(height: 100, alignment: Alignment.bottomCenter, child: Icon(Icons.keyboard_arrow_left_outlined, color: themeSelector.homeTopLineColor, size: 20,),),
                            percent: 0.0,
                          ),
                          /// 50 Percent
                          FlutterSliderHatchMarkLabel(
                            label: Container(color: themeSelector.homeGeneralBackgroundColor, child: Icon(Icons.circle_outlined, color: themeSelector.homeBoomArmSubMenuOuterCircleColor, size: 50, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeBoomArmSubMenuOuterCircleColor)],)),
                            percent: 50.0,
                          ),
                          FlutterSliderHatchMarkLabel(
                            label: Container(height: 100, alignment: Alignment.bottomCenter, child: Icon(Icons.circle_outlined, color: themeSelector.homeTopLineColor, size: 20, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeTopLineColor)],)),
                            percent: 50.0,
                          ),
                          /// 100 Percent
                          FlutterSliderHatchMarkLabel(
                            label: Container(color: themeSelector.homeGeneralBackgroundColor, child: Icon(Icons.circle_outlined, color: themeSelector.homeBoomArmSubMenuOuterCircleColor, size: 50, shadows: <Shadow>[Shadow(blurRadius: 2, color: themeSelector.homeBoomArmSubMenuOuterCircleColor)],)),
                            percent: 100.0,
                          ),
                          FlutterSliderHatchMarkLabel(
                            label: Container(height: 100, alignment: Alignment.bottomCenter, child: Icon(Icons.keyboard_arrow_right_outlined, color: themeSelector.homeTopLineColor, size: 20,),),
                            percent: 100.0,
                          ),
                        ]
                      ),
                      ignoreSteps: [FlutterSliderIgnoreSteps(from: 0.1, to: 0.9),
                                    FlutterSliderIgnoreSteps(from: 1.1, to: 1.9),],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    ElevatedButton(
                      onPressed: () {
                        boomDBUpdate(boomArmNotifier.leftArmStatus, boomArmNotifier.rightArmStatus, connectivityNotifier.isConnected2Net);
                        startBoomArmAnimation(boomArmNotifier);
                        modelNotifier.isModelLocked = false;
                        modelNotifier.orientation = '0deg 90deg auto';
                        modelNotifier.controller.runJavascript(
                            """setModel("${modelNotifier.orientation}",${modelNotifier.isModelLocked.toString()})""");
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        "CONFIRM",
                        style: TextStyle(
                          color: themeSelector.homeTopLineColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,)
                  ],
                ),
              ),
            ],
          )
        ) : Container()
    );
  }
}
