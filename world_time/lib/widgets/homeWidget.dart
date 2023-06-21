import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/themeNotifier.dart';
import 'package:world_time/widgets/mainMenuWidget.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:world_time/widgets/customPainterWidget.dart';
import 'package:world_time/widgets/expansionWidget.dart';
import 'package:world_time/widgets/languageSelectionWidget.dart';
import 'package:world_time/widgets/worldTimeWidget.dart';
import 'package:world_time/widgets/pieDrawerWidget.dart';
import 'package:world_time/widgets/engineButtonWidget.dart';
import 'package:world_time/widgets/boomArmWidget.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  final double miniIconDistancer = 16.5;

  @override
  Widget build(BuildContext context) {

    return Consumer2<ThemeSelector, LineUpdater>(
      builder: (context, themeSelector, lineUpdater, _) =>
        Scaffold(
            backgroundColor: themeSelector.homeGeneralBackgroundColor,
            body: SafeArea(
              left: false,
              right: false,
              bottom: false,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: Opacity(
                      opacity: 0.1,
                      child: Image(
                        image: const AssetImage("assets/dotWaterMark.png"),
                        width: 4000,
                        fit: BoxFit.fill,
                        isAntiAlias: true,
                        filterQuality: FilterQuality.high,
                        color: themeSelector.homeWaterMarkColor,
                      ),
                    ),
                  ),
                  Column(children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                          color: themeSelector
                              .homeTopBarBackgroundColor, //const Color.fromARGB(255, 225, 225, 225),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Image(
                                      image: AssetImage(
                                          themeSelector.runicLogo,),
                                      width: 80,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                "ON",
                                style: TextStyle(
                                  color: Colors.green[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Text(
                                  "Home",
                                  style: TextStyle(
                                    color: themeSelector.homeTopBarMenuColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                thickness: 2,
                                indent: 8,
                                endIndent: 8,
                                color: themeSelector.homeTopBarMenuColor,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/Settings');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Text(
                                  "Settings",
                                  style: TextStyle(
                                    color: themeSelector.homeTopBarMenuColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                thickness: 2,
                                indent: 8,
                                endIndent: 8,
                                color: themeSelector.homeTopBarMenuColor,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/Info');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Text(
                                  "Info",
                                  style: TextStyle(
                                    color: themeSelector.homeTopBarMenuColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 405),
                                child: Row(children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      String currentLanguage =
                                          Provider.of<LanguageUpdater>(
                                              context,
                                              listen: false)
                                              .language;
                                      if (currentLanguage == "EN") {
                                        Provider.of<LanguageUpdater>(context,
                                            listen: false)
                                            .language = "TR";
                                        Provider.of<ThemeSelector>(context,
                                            listen: false)
                                            .themeSelection = 1;
                                      } else {
                                        Provider.of<LanguageUpdater>(context,
                                            listen: false)
                                            .language = "EN";
                                        Provider.of<ThemeSelector>(context,
                                            listen: false)
                                            .themeSelection = 0;
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: const LanguageSelection(),
                                  ),
                                  const TimeUpdater(),
                                ]),
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      flex: 4,
                      child: Stack(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 9, 0, 0),
                          child: Stack(children: <Widget>[
                            CustomPaint(
                              painter: MainMenuPainter(themeSelector),
                            ),
                            Row(children: <Widget>[
                              CustomPaint(
                                size: const Size(15, 15),
                                painter:
                                CirclePainter(2, -15, 18, themeSelector),
                              ),
                              const MainMenuTimer(),
                            ]),
                          ]),
                        ),
                        Column(
                          children: <Widget>[
                            const SizedBox(height: 15),
                            Stack(
                              children: <Widget>[
                                Divider(
                                  thickness: 1,
                                  color: themeSelector.homeTopLineColor,
                                  indent: 190,
                                  endIndent: 50,
                                ),
                                Divider(
                                  thickness: 10,
                                  color: themeSelector.homeTopLineColor,
                                  indent: 875,
                                  endIndent: 50,
                                ),
                              ],
                            ),
                            Stack(children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(left: 200),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: 100,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Connection Status: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: themeSelector
                                                  .homeConnectionStatusColor,
                                            ),
                                          ),
                                          Icon(
                                            themeSelector.homeWifiStatusIcon,
                                            size: 20,
                                            color: themeSelector.homeWifiStatusColor,
                                          ),
                                        ],
                                      ))),
                              Padding(
                                padding: const EdgeInsets.only(right: 78),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  widthFactor: 100,
                                  child: Text(
                                    "IDLE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: themeSelector.homeStatusColor,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ]),
                    ),
                    Expanded(
                      flex: 40,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Stack(children: <Widget>[
                                  const MainMenu(),
                                  Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        PieDrawer(
                                            80,
                                            100,
                                            themeSelector
                                                .homeBatteryStatusIcon),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        PieDrawer(
                                            60,
                                            80,
                                            themeSelector
                                                .homeTankLevelStatusIcon),
                                      ]),
                                ]),
                              ),
                            ]),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget>[
                                const Expanded(
                                  flex: 3,
                                  child: UpdatedPaint(),
                                ),
                                Expanded(
                                  flex: 32,
                                  child: Stack(children: <Widget>[
                                    Consumer<ModelNotifier>(
                                      builder: (context, modelNotifier, _) =>
                                          ModelViewer(
                                            id: "modelID",
                                            src: 'assets/robby.glb',
                                            alt: '3D object',
                                            autoRotate: false,
                                            cameraControls: true,
                                            backgroundColor: Colors.transparent,
                                            disableZoom: true,
                                            disablePan: true,
                                            interactionPrompt: InteractionPrompt.none,
                                            minCameraOrbit: 'auto 50deg auto',
                                            maxCameraOrbit: 'auto 100deg auto',
                                            onWebViewCreated: (controller) => {
                                              modelNotifier.controller = controller, //Set the controller up
                                            },
                                            interpolationDecay: 200,
                                            relatedJs: """
                                              function setModel(orientation, lockState){
                                                const modelViewer = document.querySelector('#modelID');
                                                modelViewer.cameraOrbit = orientation;
                                                modelViewer.cameraControls = !lockState; 
                                              }
                                            """,
                                          ),
                                    ),
                                  ]),
                                ),
                                const Expanded(
                                  flex: 4,
                                  child: EngineButton(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  const TriggerExpansion(),
                                  const boomArmMenu(),
                                  Consumer<ExpansionNotifier>(
                                    builder: (context, expansionNotifier, _) =>
                                    expansionNotifier.isTriggered && expansionNotifier.counter == 100 ?
                                    Positioned(
                                      top: 185,
                                      left: 0,
                                      child: SizedBox(
                                          width: 50,
                                          height: 220,
                                          child: FlutterSlider(
                                              values: [expansionNotifier.escalation + 57],
                                              rtl: true,
                                              axis: Axis.vertical,
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
                                                child: Icon(Icons.vertical_align_center, color: themeSelector.homeExpansionSliderMainColor,),
                                              ),
                                              tooltip: FlutterSliderTooltip(
                                                  format: (String value) {
                                                    return (double.parse(value) - 57).toString();
                                                  },
                                                  boxStyle: const FlutterSliderTooltipBox(
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                  textStyle:  TextStyle(color: themeSelector.homeTopLineColor, fontWeight: FontWeight.bold, fontSize: 12,),
                                                  positionOffset: FlutterSliderTooltipPositionOffset(
                                                    top: expansionNotifier.escalation * 37 / 20 - 80,
                                                  ),
                                                  alwaysShowTooltip: true,
                                              ),
                                              max: 100,
                                              min: 0,
                                              ignoreSteps: [
                                                FlutterSliderIgnoreSteps(from: -5, to: 56)],
                                              onDragging: (handlerIndex, lowerValue, upperValue){
                                                expansionNotifier.escalation = lowerValue - 57;
                                              }
                                          )
                                      ),
                                    ) : Container(),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            )),
    );
  }
}
