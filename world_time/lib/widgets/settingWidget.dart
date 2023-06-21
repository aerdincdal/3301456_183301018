import 'package:flutter/material.dart';
import 'package:world_time/themeNotifier.dart';
import 'package:provider/provider.dart';


class SettingUnit extends StatefulWidget {
  final String settingDescription;
  final bool settingState;
  final ValueChanged<bool> onChanged;
  const SettingUnit({Key? key, required this.settingDescription, required this.settingState, required this.onChanged}) : super(key: key);
  @override
  State<SettingUnit> createState() => _SettingUnitState();
}

class _SettingUnitState extends State<SettingUnit> {

  late bool settingState;

  @override
  void initState(){
    super.initState();
    settingState = widget.settingState;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeSelector>(
      builder: (context, themeSelector, _) =>
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
                              widget.settingDescription,
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
                              Switch(
                                value: settingState,
                                activeColor: themeSelector.homeTopBarLanguageColor,
                                inactiveTrackColor: themeSelector.homeTopBarLanguageColor,
                                onChanged: (bool value) {

                                  setState( () {
                                    settingState = value;
                                    widget.onChanged(value);
                                  });
                                },
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
    );
  }
}