import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/themeNotifier.dart';

class MainMenuTimer extends StatefulWidget {
  const MainMenuTimer({Key? key}) : super(key: key);

  @override
  State<MainMenuTimer> createState() => _MainMenuTimerState();
}

class _MainMenuTimerState extends State<MainMenuTimer> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeOutCubic,
    )..addListener(() {
      final state = Provider.of<MainMenuUpdater>(context, listen: false);
      if (!state.isMenuOpened) {
        state.menuDrawer = (animationController!.value * 200);
        if (state.menuDrawer <= 50) {
          state.subMenuDrawer = state.menuDrawer;
        } else {
          state.subMenuDrawer = 50;
        }
        if (animationController!.value == 1.0) stopAnimation(state);
      } else {
        state.menuDrawer = (animationController!.value * 200);
        if (state.menuDrawer <= 50) state.subMenuDrawer = state.menuDrawer;
        if (animationController!.value == 0.0) stopAnimation(state);
      }
    });
  }

  void startAnimation(MainMenuUpdater state) {
    state.isMenuDrawerActive = true;
    if (state.isMenuOpened) {
      animationController?.reverse(from: 1);
    } else {
      animationController?.forward(from: 0);
    }
  }

  void stopAnimation(MainMenuUpdater state) {
    state.isMenuOpened = !state.isMenuOpened;
    state.isMenuDrawerActive = false;
    animationController!.stop();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeSelector, MainMenuUpdater>(
      builder: (context, themeSelector, mainMenuUpdater, _) => ElevatedButton(
        onPressed: () {
          if (!mainMenuUpdater.isMenuDrawerActive) {
            mainMenuUpdater.isMenuDrawerActive = true;
            startAnimation(mainMenuUpdater);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text("MENU",
            style: TextStyle(
              color: themeSelector.homeMenuButtonMainColor,
              fontSize: 25,
              shadows: <Shadow>[
                Shadow(
                  offset: const Offset(1.0, 1.0),
                  blurRadius: 2.0,
                  color: themeSelector.homeMenuButtonShadowColor1,
                ),
                Shadow(
                  offset: const Offset(1.0, 1.0),
                  blurRadius: 4.0,
                  color: themeSelector.homeMenuButtonShadowColor2,
                ),
              ],
            )),
      ),
    );
  }
}

class MainMenuDrawer extends CustomPainter {
  dynamic p2, p4, p6;

  final Offset _startingFirst;
  final Offset _startingSecond;
  final Offset _startingThird;
  ThemeSelector themeSelector;

  MainMenuDrawer(double timeBasedOffset, this._startingFirst,
      this._startingSecond, this._startingThird, this.themeSelector) {
    p2 = Offset(
        _startingFirst.dx,
        _startingFirst.dy +
            ((_startingSecond.dy - _startingFirst.dy) * 0 / 100));
    p4 = Offset(
        _startingSecond.dx +
            ((_startingThird.dx - _startingSecond.dx) * 0 / 100),
        _startingSecond.dy +
            ((_startingThird.dy - _startingSecond.dy) * 0 / 100));
    p6 = Offset(_startingThird.dx + (0 / 2), _startingThird.dy);

    if (timeBasedOffset >= 0 && timeBasedOffset <= 100) {
      p2 = Offset(
          _startingFirst.dx,
          _startingFirst.dy +
              ((_startingSecond.dy - _startingFirst.dy) *
                  timeBasedOffset /
                  100));
    } else if (timeBasedOffset > 100 && timeBasedOffset <= 150) {
      timeBasedOffset = (timeBasedOffset - 100) * 2;
      p2 = Offset(
          _startingFirst.dx,
          _startingFirst.dy +
              ((_startingSecond.dy - _startingFirst.dy) * 100 / 100));
      p4 = Offset(
          _startingSecond.dx +
              ((_startingThird.dx - _startingSecond.dx) *
                  timeBasedOffset /
                  100),
          _startingSecond.dy +
              ((_startingThird.dy - _startingSecond.dy) *
                  timeBasedOffset /
                  100));
    } else {
      timeBasedOffset = (timeBasedOffset - 150) * 2;
      p2 = Offset(
          _startingFirst.dx,
          _startingFirst.dy +
              ((_startingSecond.dy - _startingFirst.dy) * 100 / 100));
      p4 = Offset(
          _startingSecond.dx +
              ((_startingThird.dx - _startingSecond.dx) * 100 / 100),
          _startingSecond.dy +
              ((_startingThird.dy - _startingSecond.dy) * 100 / 100));
      p6 = Offset(
          _startingThird.dx + (timeBasedOffset * 5 / 4), _startingThird.dy);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Color lineColor = themeSelector.homeTopLineColor;

    final Offset p1 = _startingFirst;
    final Offset p3 = _startingSecond;
    final Offset p5 = _startingThird;

    final paint1 = Paint()
      ..color = lineColor
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint1);

    final paint2 = Paint()
      ..color = lineColor
      ..strokeWidth = 1;
    canvas.drawLine(p3, p4, paint2);

    final paint3 = Paint()
      ..color = lineColor
      ..strokeWidth = 5;
    canvas.drawLine(p5, p6, paint3);
  }

  @override
  bool shouldRepaint(covariant MainMenuDrawer oldDelegate) {
    return oldDelegate.p2 != p2 || oldDelegate.p4 != p4 || oldDelegate.p6 != p6;
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  final double _firstDx = 27.5;
  final double _firstDy = 0;
  final double _firstDxDistancer = 2.5;
  final double _menuDx = 30;
  final double _middleMenuDy = 295;
  final double _menuDistancer = 80;
  final double _menuButtonAdditionalDistancer = 32;

  // - - - - -
  // _firstDxDistancer
  //  ___
  //  | |--------------------> _firstDx
  //  | |
  //  | |
  //  | |   . ---------------> _menuDx
  //  | |   .
  //  | |   .
  //  | |\  .
  //  | | \ .
  //  | |  \_ _ _ _ _
  //  | |   . }
  //  | |\  . } } -----------> _menuDistancer
  //  | | \ . }
  //  | |  \_ _ _ _ _
  //  | |   .
  //  | |\  .
  //  | | \ .
  //  | |  \_ _ _ _ _ -------> _middleMenuDy

  @override
  Widget build(BuildContext context) {
    return Consumer2<MainMenuUpdater, ThemeSelector>(
        builder: (context, mainMenuUpdater, themeSelector, _) => Stack(
          children: <Widget>[
            /// First Menu
            CustomPaint(
              painter: MainMenuDrawer(
                  mainMenuUpdater.menuDrawer,
                  Offset(_firstDx + 2 * _firstDxDistancer, _firstDy - 1),
                  Offset(
                      _firstDx + 2 * _firstDxDistancer,
                      (_middleMenuDy -
                          (2 * _menuDistancer) -
                          _menuDx +
                          (2 * _firstDxDistancer))),
                  Offset(_firstDx + _menuDx,
                      (_middleMenuDy - (2 * _menuDistancer))),
                  themeSelector),
            ),

            /// Second Menu
            /* CustomPaint(
            painter: MainMenuDrawer(  mainMenuUpdater.menuDrawer ,
                Offset(_firstDx + _firstDxDistancer, _firstDy),
                Offset(_firstDx + _firstDxDistancer, ( _middleMenuDy - ( _menuDistancer ) - _menuDx + (_firstDxDistancer) ) ),
                Offset(_firstDx + _menuDx, (_middleMenuDy - (_menuDistancer))),
                themeSelector),
          ),*/
            /// Third Menu
            CustomPaint(
              painter: MainMenuDrawer(
                  mainMenuUpdater.menuDrawer,
                  Offset(_firstDx, _firstDy),
                  Offset(_firstDx, (_middleMenuDy) - _menuDx),
                  Offset(_firstDx + _menuDx, (_middleMenuDy)),
                  themeSelector),
            ),

            /// Forth Menu
            /* CustomPaint(
            painter: MainMenuDrawer(  mainMenuUpdater.menuDrawer ,
                Offset(_firstDx - _firstDxDistancer, _firstDy),
                Offset(_firstDx - _firstDxDistancer, ( _middleMenuDy + ( _menuDistancer ) - _menuDx - (_firstDxDistancer) ) ),
                Offset(_firstDx + _menuDx, (_middleMenuDy + (_menuDistancer))),
                themeSelector),
          ),*/
            /// Fifth Menu
            CustomPaint(
              painter: MainMenuDrawer(
                  mainMenuUpdater.menuDrawer,
                  Offset(_firstDx - 2 * _firstDxDistancer, _firstDy - 1),
                  Offset(
                      _firstDx - 2 * _firstDxDistancer,
                      (_middleMenuDy +
                          (2 * _menuDistancer) -
                          _menuDx -
                          (2 * _firstDxDistancer))),
                  Offset(_firstDx + _menuDx,
                      (_middleMenuDy + (2 * _menuDistancer))),
                  themeSelector),
            ),

            /// MENU BUTTONS
            mainMenuUpdater.menuDrawer > 100
                ? Opacity(
              opacity: mainMenuUpdater.menuDrawer > 150
                  ? ((mainMenuUpdater.menuDrawer - 150) / 50)
                  : 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 102, 0, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/VehicleSettings');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "VEHICLE SETTINGS",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: themeSelector
                                      .homeMenuSubButtonColor,
                                  shadows: const <Shadow>[
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 10.0,
                                        offset: Offset(0, 17)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15, 15, 0, 0),
                                child: Icon(
                                  Icons.construction,
                                  color: themeSelector
                                      .homeMenuSubButtonColor,
                                  size: 30,
                                  shadows: [
                                    Shadow(
                                        color: themeSelector
                                            .homeMenuSubButtonColor,
                                        blurRadius: 2)
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: _menuDistancer +
                            _menuButtonAdditionalDistancer,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/FlowSettings');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "FLOW SETTINGS",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: themeSelector
                                      .homeMenuSubButtonColor,
                                  shadows: const <Shadow>[
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 10.0,
                                        offset: Offset(0, 17)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    31, 15, 0, 0),
                                child: Icon(
                                  Icons.bloodtype,
                                  color: themeSelector
                                      .homeMenuSubButtonColor,
                                  size: 30,
                                  shadows: [
                                    Shadow(
                                        color: themeSelector
                                            .homeMenuSubButtonColor,
                                        blurRadius: 2)
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: _menuDistancer +
                            _menuButtonAdditionalDistancer,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/FieldBorders');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "FIELD BORDERS",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: themeSelector
                                      .homeMenuSubButtonColor,
                                  shadows: const <Shadow>[
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 10.0,
                                        offset: Offset(0, 17)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    34, 15, 0, 0),
                                child: Icon(
                                  Icons.border_outer_rounded,
                                  color: themeSelector
                                      .homeMenuSubButtonColor,
                                  size: 30,
                                  shadows: [
                                    Shadow(
                                        color: themeSelector
                                            .homeMenuSubButtonColor,
                                        blurRadius: 2)
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ]),
              ),
            )
                : Container(),
          ],
        ));
  }
}
