import 'package:flutter/material.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/themeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:world_time/widgets/customPainterWidget.dart';
import 'package:pie_chart/pie_chart.dart';


class PieDrawer extends StatefulWidget {
  final Map<String, double> dataMap;
  final double ratio;
  final double scale;
  final IconData icon;

  PieDrawer(this.ratio, this.scale, this.icon, {Key? key})
      : dataMap = <String, double>{
    "Data": ratio,
    "Rest": 100 - ratio,
  },
        super(key: key);

  @override
  State<PieDrawer> createState() => _PieDrawerState();
}

class _PieDrawerState extends State<PieDrawer> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeSelector, MainMenuUpdater>(
      builder: (context, themeSelector, mainMenuUpdater, _) => SizedBox(
        height: 130 * (widget.scale / 100),
        child: Opacity(
          opacity: (50 - mainMenuUpdater.subMenuDrawer) / 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  CustomPaint(
                    size: Size(
                        44 * (widget.scale / 100), 44 * (widget.scale / 100)),
                    painter: CirclePainter(1, 0, 0, themeSelector),
                  ),
                  Text(
                    "${widget.ratio}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13 * (widget.scale / 100),
                      color: themeSelector.homePieChartTextColor,
                    ),
                  ),
                  PieChart(
                    dataMap: widget.dataMap,
                    colorList: [
                      themeSelector.homePieChartMainColor,
                      themeSelector.homeGeneralBackgroundColor
                    ],
                    chartLegendSpacing: 0,
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      chartValueBackgroundColor: Colors.transparent,
                      showChartValuesOutside: false,
                      showChartValues: false,
                    ),
                    totalValue: 100,
                    initialAngleInDegree: -90,
                    chartRadius: 80 * (widget.scale / 100),
                    chartType: ChartType.ring,
                    ringStrokeWidth: 35 * (widget.scale / 100),
                    animationDuration: const Duration(seconds: 5),
                  ),
                  CustomPaint(
                    size: Size(
                        114 * (widget.scale / 100), 114 * (widget.scale / 100)),
                    painter: CirclePainter(2.0, 0, 0, themeSelector),
                  ),
                ],
              ),
              SizedBox(
                width: 10 * (widget.scale / 100),
              ),
              VerticalDivider(
                color: themeSelector.homePieChartIconColor,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Icon(
                widget.icon,
                color: themeSelector.homePieChartIconColor,
                size: 40 * (widget.scale / 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
