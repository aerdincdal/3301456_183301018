import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/widgets/powerButtonWidget.dart';
import 'package:world_time/themeNotifier.dart';


class OpeningHome extends StatefulWidget {
  const OpeningHome({Key? key}) : super(key: key);

  @override
  State<OpeningHome> createState() => _OpeningHomeState();
}

class _OpeningHomeState extends State<OpeningHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeSelector>(
      builder: (context, themeSelector, _) =>
        Scaffold(
          backgroundColor: themeSelector.homeGeneralBackgroundColor,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: (Provider.of<PowerButtonOpacity>(context)
                                  .generalOpacity /
                              100.0),
                          child: const Image(
                            image: AssetImage("assets/runicLogo.png"),
                            isAntiAlias: true,
                          ),
                        ))),
                Expanded(
                  flex: 24,
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(children: <Widget>[
                      Opacity(
                        opacity: (Provider.of<PowerButtonOpacity>(context)
                                .generalOpacity /
                            100.0),
                        child: Image(
                          image: const AssetImage("assets/powerButton.png"),
                          filterQuality: FilterQuality.high,
                          isAntiAlias: true,
                          width: 120,
                          color: Colors.grey[900],
                        ),
                      ),
                      const PowerOpacity(),
                      const Opacity(
                        opacity: 0.0,
                        child: PowerOpacityTrigger(),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          )
        )
    );
  }
}
