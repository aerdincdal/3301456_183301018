import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';


class ThemeSelector extends ChangeNotifier{
  // Initiator
  int _themeSelection = 0;
  bool _isHeadlightOn = false;

  /// *** COLOR & ICONS *** ///
  Color _homeGeneralBackgroundColor = Colors.blueGrey[800]!;    // Background Color               | Home Screen

  Color _homeWaterMarkColor = Colors.white;                     // Watermark Color                | Home Screen

  Color _homeTopBarBackgroundColor = Colors.grey[900]!;         // Top bar Background             | HOME Screen
  Color _homeTopBarMenuColor = Colors.grey[600]!;               // Top bar Menu                   | HOME Screen
  Color _homeTopBarTimeColor = Colors.grey[600]!;               // Top bar Clock Display          | HOME Screen
  Color _homeTopBarLanguageColor = Colors.grey[400]!;           // Top bar Language Selection     | HOME Screen

  Color _homeMenuButtonMainColor = Colors.grey[400]!;           // Below Top bar Menu Button      | HOME Screen
  // Home Menu Button Line Color is same as _homeTopLineColor
  Color _homeMenuButtonShadowColor1 = Colors.grey[200]!;        // Below Top bar Menu Shadow      | HOME Screen
  Color _homeMenuButtonShadowColor2 = Colors.grey[400]!;        // Below Top bar Menu Shadow 2    | HOME Screen
  Color _homeMenuSubButtonColor = Colors.white;

  Color _homeTopLineColor = Colors.black;                       // Top Line                       | HOME Screen
  Color _homeConnectionStatusColor = Colors.grey[900]!;         // Connection Status              | HOME Screen
  Color _homeWifiStatusColor = Colors.green[400]!;              // Wifi Status Color              | HOME Screen

  final IconData _homeWifiStatusIcon = Icons.wifi;                    // Wifi Status Icon               | HOME Screen
  final IconData _homeBatteryStatusIcon = Icons.battery_charging_full_rounded;  // Battery Status Icon  | HOME Screen
  final IconData _homeTankLevelStatusIcon = Icons.water_drop_outlined;// Tank Level Status Icon         | HOME Screen

  final IconData _homeFlowSettingIcon = PhosphorIcons.regular.plant;

  final IconData _homeManuelDriveIcon=PhosphorIcons.regular.steeringWheel;// Manuel Control Icon  | HOME Screen
  final IconData _homeVehicleMonitorIcon = PhosphorIcons.regular.path;    // Vehicle Monitor Icon | HOME Screen
  final IconData _homeBoomArmIcon=PhosphorIcons.regular.arrowsHorizontal; // Boom Arm Icon        | HOME Screen
  final IconData _homeHeadlightIcon = PhosphorIcons.regular.headlights;   // HeadLight Icon       | HOME Screen
  Color _homeHeadlightIconColor = Colors.white;
  final IconData _homeExpansionIcon = Icons.expand;                       // Expansion Icon       | HOME Screen

  String _runicLogo = "assets/runicLogo.png";

  Color _homeStatusColor = Colors.yellow[400]!;                 // Status of vehicle              | HOME Screen

  Color _homeRightMenuLineColorPrimary = Colors.brown[200]!;    // Right Menu Line Primary        | HOME Screen
  Color _homeRightMenuLineColorSecondary = Colors.brown[200]!;  // Right Menu Line Secondary      | HOME Screen

  Color _homeSmallCircleColor = Colors.grey[900]!;              // Small Circle                   | HOME Screen

  Color _homePieChartMainColor = Colors.green[400]!;            // Pie Chart Graph                | HOME Screen
  Color _homePieChartIconColor = Colors.grey[300]!;            // Pie Chart Icon                  | HOME Screen
  Color _homePieChartTextColor = Colors.grey[300]!;             // Pie Chart Text                 | HOME Screen
  // Home Pie Chart Secondary Color is same as _homeGeneralBackgroundColor

  Color _homeBottomButtonEmergency = Colors.red[800]!;          // Bottom Button Emergency        | HOME Screen
  Color _homeBottomButtonAutonomous = Colors.green[600]!;       // Bottom Button Autonomous       | HOME Screen

  Color _homeExpansionSliderMainColor = Colors.black;           // Expansion Slider Color         | HOME Screen

  Color _homeBoomArmSubMenuOuterCircleColor = Colors.grey[900]!;// BoomArm Sub Menu Circle Color  | HOME Screen


  // Getter
  int get themeSelection => _themeSelection;
  bool get isHeadlightOn => _isHeadlightOn;

  /// *** COLORS & ICONS *** ///
  Color get homeGeneralBackgroundColor => _homeGeneralBackgroundColor;

  Color get homeWaterMarkColor => _homeWaterMarkColor;

  Color get homeTopBarBackgroundColor => _homeTopBarBackgroundColor;
  Color get homeTopBarMenuColor => _homeTopBarMenuColor;
  Color get homeTopBarTimeColor => _homeTopBarTimeColor;
  Color get homeTopBarLanguageColor => _homeTopBarLanguageColor;

  Color get homeMenuButtonMainColor => _homeMenuButtonMainColor;
  Color get homeMenuButtonShadowColor1 => _homeMenuButtonShadowColor1;
  Color get homeMenuButtonShadowColor2 => _homeMenuButtonShadowColor2;
  Color get homeMenuSubButtonColor => _homeMenuSubButtonColor;

  Color get homeTopLineColor => _homeTopLineColor;
  Color get homeConnectionStatusColor => _homeConnectionStatusColor;
  Color get homeWifiStatusColor => _homeWifiStatusColor;

  IconData get homeWifiStatusIcon => _homeWifiStatusIcon;
  IconData get homeBatteryStatusIcon => _homeBatteryStatusIcon;
  IconData get homeTankLevelStatusIcon => _homeTankLevelStatusIcon;

  IconData get homeFlowSettingIcon => _homeFlowSettingIcon;

  IconData get homeManuelDriveIcon => _homeManuelDriveIcon;// Manuel Control Icon            | HOME Screen
  IconData get homeVehicleMonitorIcon => _homeVehicleMonitorIcon;    // Vehicle Monitor Icon           | HOME Screen
  IconData get homeBoomArmIcon => _homeBoomArmIcon; // Boom Arm Icon                  | HOME Screen
  IconData get homeHeadlightIcon => _homeHeadlightIcon;   // HeadLight Icon                 | HOME Screen
  IconData get homeExpansionIcon => _homeExpansionIcon;
  Color get homeHeadlightIconColor => _homeHeadlightIconColor;

  String get runicLogo => _runicLogo;

  Color get homeStatusColor => _homeStatusColor;

  Color get homeRightMenuLineColorPrimary => _homeRightMenuLineColorPrimary;
  Color get homeRightMenuLineColorSecondary => _homeRightMenuLineColorSecondary;

  Color get homeSmallCircleColor => _homeSmallCircleColor;

  Color get homePieChartMainColor => _homePieChartMainColor;
  Color get homePieChartIconColor => _homePieChartIconColor;
  Color get homePieChartTextColor => _homePieChartTextColor;


  Color get homeBottomButtonEmergency => _homeBottomButtonEmergency;
  Color get homeBottomButtonAutonomous => _homeBottomButtonAutonomous;

  Color get homeExpansionSliderMainColor => _homeExpansionSliderMainColor;

  Color get homeBoomArmSubMenuOuterCircleColor => _homeBoomArmSubMenuOuterCircleColor;

  set isHeadlightOn (bool newValue){
    _isHeadlightOn = newValue;
    if (newValue){
      if (_themeSelection == 0){
        _homeHeadlightIconColor = Colors.yellow;
      }
      else{
        _homeHeadlightIconColor = Colors.yellow[700]!;
      }
    }
    else{
      if (_themeSelection == 0){
        _homeHeadlightIconColor = Colors.white;
      }
      else{
        _homeHeadlightIconColor = Colors.brown[400]!;
      }
    }
    notifyListeners();
  }

  set homeWifiStatusColor(Color connectionStatusColor){
    _homeWifiStatusColor = connectionStatusColor;
    notifyListeners();
  }

  set themeSelection(int newTheme){

    switch(newTheme){

      case 0: {
        _homeGeneralBackgroundColor = Colors.blueGrey[800]!;    // Background Color               | Home Screen

        _homeWaterMarkColor = Colors.white;                     // Watermark Color                | Home Screen

        _homeTopBarBackgroundColor = Colors.grey[900]!;         // Top bar Background             | HOME Screen
        _homeTopBarMenuColor = Colors.grey[600]!;               // Top bar Menu                   | HOME Screen
        _homeTopBarTimeColor = Colors.grey[600]!;               // Top bar Clock Display          | HOME Screen
        _homeTopBarLanguageColor = Colors.grey[400]!;           // Top bar Language Selection     | HOME Screen

        _homeMenuButtonMainColor = Colors.grey[400]!;           // Below Top bar Menu Button      | HOME Screen
        _homeMenuButtonShadowColor1 = Colors.grey[200]!;        // Below Top bar Menu Shadow      | HOME Screen
        _homeMenuButtonShadowColor2 = Colors.grey[400]!;        // Below Top bar Menu Shadow 2    | HOME Screen
        _homeMenuSubButtonColor = Colors.white;

        if (_isHeadlightOn){
          _homeHeadlightIconColor = Colors.yellow;
        }
        else{
          _homeHeadlightIconColor = Colors.white;
        }


        _homeTopLineColor = Colors.black;                       // Top Line                       | HOME Screen
        _homeConnectionStatusColor = Colors.grey[900]!;         // Connection Status              | HOME Screen

        _homeStatusColor = Colors.yellow[400]!;                 // Status of vehicle              | HOME Screen

        _homeRightMenuLineColorPrimary = Colors.brown[200]!;    // Right Menu Line Primary        | HOME Screen
        _homeRightMenuLineColorSecondary = Colors.brown[200]!;  // Right Menu Line Secondary      | HOME Screen

        _homeSmallCircleColor = Colors.grey[900]!;              // Small Circle                   | HOME Screen

        _homePieChartMainColor = Colors.green[400]!;            // Pie Chart Graph                | HOME Screen
        _homePieChartIconColor = Colors.grey[300]!;            // Pie Chart Icon                 | HOME Screen
        _homePieChartTextColor = Colors.grey[300]!;             // Pie Chart Text                 | HOME Screen

        _homeBottomButtonEmergency = Colors.red[800]!;          // Bottom Button Emergency        | HOME Screen
        _homeBottomButtonAutonomous = Colors.green[600]!;       // Bottom Button Autonomous       | HOME Screen

        _homeExpansionSliderMainColor = Colors.black;

        _homeBoomArmSubMenuOuterCircleColor = Colors.grey[900]!;

        _runicLogo = "assets/runicLogo.png";
      }break;

      case 1: {

        _homeGeneralBackgroundColor = Colors.brown[50]!;        // Background Color               | HOME Screen

        _homeWaterMarkColor = Colors.black;                    // Watermark Color                | HOME Screen

        _homeTopBarBackgroundColor = const Color.fromRGBO(228, 226, 223, 1.0); // Top bar Background             | HOME Screen
        _homeTopBarMenuColor = Colors.grey[600]!;               // Top bar Menu                   | HOME Screen
        _homeTopBarTimeColor = Colors.grey[600]!;               // Top bar Clock Display          | HOME Screen
        _homeTopBarLanguageColor = Colors.brown[400]!;          // Top bar Language Selection     | HOME Screen

        _homeMenuButtonMainColor = Colors.brown[400]!;          // Below Top bar Menu Button      | HOME Screen
        _homeMenuButtonShadowColor1 = Colors.grey[200]!;        // Below Top bar Menu Shadow      | HOME Screen
        _homeMenuButtonShadowColor2 = Colors.grey[400]!;        // Below Top bar Menu Shadow 2    | HOME Screen
        _homeMenuSubButtonColor = Colors.brown[400]!;

        if(!_isHeadlightOn){
          _homeHeadlightIconColor = Colors.brown[400]!;
        }
        else{
          _homeHeadlightIconColor = Colors.yellow[700]!;
        }

        _homeTopLineColor = Colors.brown[300]!;                 // Top Line                       | HOME Screen
        _homeConnectionStatusColor = Colors.brown[200]!;        // Connection Status              | HOME Screen

        _homeStatusColor = Colors.yellow[700]!;                 // Status of vehicle              | HOME Screen

        _homeRightMenuLineColorPrimary = Colors.brown[200]!;    // Right Menu Line Primary        | HOME Screen
        _homeRightMenuLineColorSecondary = Colors.brown[200]!;  // Right Menu Line Secondary      | HOME Screen

        _homeSmallCircleColor = Colors.brown[300]!;             // Small Circle                   | HOME Screen

        _homePieChartMainColor = Colors.brown[300]!;            // Pie Chart Graph                | HOME Screen
        _homePieChartIconColor = Colors.brown[400]!;            // Pie Chart Icons                | HOME Screen
        _homePieChartTextColor = Colors.grey[600]!;

        _homeBottomButtonEmergency = Colors.red[800]!;          // Bottom Button Emergency        | Home Screen
        _homeBottomButtonAutonomous = Colors.green[600]!;       // Bottom Button Autonomous       | Home Screen

        _homeExpansionSliderMainColor = Colors.brown[400]!;

        _homeBoomArmSubMenuOuterCircleColor = Colors.brown[200]!;

        _runicLogo = "assets/runicLogo.png";
      }break;
    }

    _themeSelection = newTheme;
    notifyListeners();
  }
}
