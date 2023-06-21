import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';
import 'package:world_time/themeNotifier.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/widgets/languageSelectionWidget.dart';
import 'package:world_time/widgets/worldTimeWidget.dart';
import 'package:world_time/widgets/settingWidget.dart';

class VehicleSettings extends StatefulWidget {
  const VehicleSettings({Key? key}) : super(key: key);

  @override
  State<VehicleSettings> createState() => _VehicleSettingsState();
}

class _VehicleSettingsState extends State<VehicleSettings> {

  double sliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeSelector>(
      builder: (context, themeSelector, _) => Scaffold(
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
              Column(
                children: <Widget>[
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
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Text(
                                    "<<BACK",
                                    style: TextStyle(
                                      color: themeSelector
                                          .homeTopBarLanguageColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                              onPressed: () {
                                Navigator.pop(context);
                              },
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
                              onPressed: () {},
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
                              onPressed: () {},
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
                                        Provider.of<LanguageUpdater>(context,
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
                    flex: 43,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                children: <Widget> [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget> [
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: <Widget> [
                                                const SizedBox(width: 10),
                                                Text(
                                                  "Maximum Allowed Velocity",
                                                  style: TextStyle(
                                                    color: themeSelector.homeTopBarLanguageColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget> [
                                                  SizedBox(
                                                      width: 130,
                                                      height: 50,
                                                      child: FlutterSlider(
                                                          values: [sliderValue],
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
                                                              top: -7,
                                                            ),
                                                            alwaysShowTooltip: true,
                                                          ),
                                                          max: 25,
                                                          min: 10,
                                                          onDragging: (handlerIndex, lowerValue, upperValue){
                                                            setState(() {
                                                              sliderValue = lowerValue;
                                                            });
                                                          }
                                                      )
                                                  ),
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            )
                                        )
                                      ]
                                  ),
                                ],
                              ),
                            ),
                            SettingUnit(
                              settingDescription: "Apply Restrictions",
                              settingState: false,
                              onChanged: (bool value) {
                                
                              },
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
