import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LineUpdater extends ChangeNotifier{
  // Initiator
  double _stateManagementIncrementer = 0;
  bool _isTimerActive = false;
  bool _isOpened = false;

  bool _isTriggerEvent = false;

  // Getter
  double get stateManagementIncrementer => _stateManagementIncrementer;
  bool get isTimerActive => _isTimerActive;
  bool get isOpened => _isOpened;
  bool get isTriggerEvent => _isTriggerEvent;

  // Setter
  set stateManagementIncrementer(double newValue)
  {
    _stateManagementIncrementer = newValue;
    notifyListeners();
  }

  set isTimerActive(bool newValue)
  {
    _isTimerActive = newValue;
    notifyListeners();
  }

  set isOpened(bool newValue){
    _isOpened = newValue;
    notifyListeners();
  }

  set isTriggerEvent(bool newValue){
    _isTriggerEvent = newValue;
    notifyListeners();
  }

}

class TimeNotifier extends ChangeNotifier{
  // Initiator
  String _current_time = "${DateTime.now().hour}:${DateTime.now().minute}";

  // Getter
  String get current_time => _current_time;

  // Setter
  set current_time(String newTime)
  {
    _current_time = newTime;
    notifyListeners();
  }
}

class LanguageUpdater extends ChangeNotifier{
  // Initiator
  String _language = "EN";

  // Getter
  String get language => _language;

  // Setter
  set language(String newLanguage)
  {
    _language = newLanguage;
    notifyListeners();
  }
}

class MainMenuUpdater extends ChangeNotifier{
  // Initiator
  double _menuDrawer = 0;
  double _subMenuDrawer = 0;
  bool _isMenuDrawerActive = false;
  bool _isMenuOpened = false;

  // Getter
  double get menuDrawer => _menuDrawer;
  double get subMenuDrawer => _subMenuDrawer;
  bool get isMenuDrawerActive => _isMenuDrawerActive;
  bool get isMenuOpened => _isMenuOpened;

  // Setter
  set menuDrawer(double newValue){
    _menuDrawer = newValue;
    notifyListeners();
  }

  set subMenuDrawer(double newValue){
    _subMenuDrawer = newValue;
    notifyListeners();
  }

  set isMenuOpened(bool newValue){
    _isMenuOpened = newValue;
    notifyListeners();
  }

  set isMenuDrawerActive(bool newValue){
    _isMenuDrawerActive = newValue;
    notifyListeners();
  }

}

class PowerButtonOpacity extends ChangeNotifier{
  // Initiator
  double _opacity = 0.0;
  double _generalOpacity = 100.0;
  bool _isPowerButton = true;

  //Getter
  double get opacity => _opacity;
  double get generalOpacity => _generalOpacity;
  bool get isPowerButton => _isPowerButton;

  // Setter
  set opacity(double newValue){
    _opacity = newValue;
    notifyListeners();
  }
  set generalOpacity(double newValue){
    _generalOpacity = newValue;
    notifyListeners();
  }
  set isPowerButton(bool newValue){
    _isPowerButton = newValue;
    notifyListeners();
  }
}

class ModelNotifier extends ChangeNotifier{
  //Initiate
  bool _isModelLocked = false;
  String _orientation = "";
  Color _background = Colors.transparent;
  var _controller;

  bool get isModelLocked => _isModelLocked;
  String get orientation => _orientation;
  Color get background => _background;
  get controller => _controller;

  set isModelLocked(bool newValue){
    _isModelLocked = newValue;
    notifyListeners();
  }
  set orientation(String newValue){
    // Zero value: '0deg 90deg auto'
    _orientation = newValue;
    notifyListeners();
  }

  set controller(var controller){
    _controller = controller;
    notifyListeners();
  }

  set background(Color newValue){
    _background = newValue;
    notifyListeners();
  }

}

class ExpansionNotifier extends ChangeNotifier{
  // Initiator
  bool _isTriggered = false;
  bool _isExpansionMenuOpened = false;
  bool _isExpansionMenuOpening = false;
  double _counter = 0;
  double _trackLength = 10;
  double _escalation = 0;

  // Getter
  bool get isTriggered => _isTriggered;
  bool get isExpansionMenuOpened => _isExpansionMenuOpened;
  bool get isExpansionMenuOpening => _isExpansionMenuOpening;
  double get counter => _counter;
  double get trackLength => _trackLength;
  double get escalation => _escalation;

  // Setter
  set isTriggered(bool newValue){
    _isTriggered = newValue;
    notifyListeners();
  }
  set isExpansionMenuOpened(bool newValue){
    _isExpansionMenuOpened = newValue;
    notifyListeners();
  }
  set isExpansionMenuOpening(bool newValue){
    _isExpansionMenuOpening = newValue;
    notifyListeners();
  }
  set counter(double newValue){
    _counter = newValue;
    notifyListeners();
  }

  set trackLength(double newValue){
    _trackLength = newValue;
    notifyListeners();
  }
  set escalation(double newValue){
    _escalation = newValue;
    notifyListeners();
  }
}

class BoomArmNotifier extends ChangeNotifier{
  // Initiator
  bool _isTriggered = false;
  bool _isBoomArmMenuOpened = false;
  double _counter = 0;

  double _leftArmStatus = 0;    // 0: Closed, 1: Semi-Opened, 2: Opened
  double _rightArmStatus = 0;   // 0: Closed, 1: Semi-Opened, 2: Opened

  double _whichArm = 0;  //   0  : Center (Both Arms will be effected)
                      //  -1  : Left Arm
                      //   1  : Right Arm

  // Getter
  bool get isTriggered => _isTriggered;
  bool get isBoomArmMenuOpened => _isBoomArmMenuOpened;
  double get whichArm => _whichArm;

  double get leftArmStatus => _leftArmStatus;
  double get rightArmStatus => _rightArmStatus;

  double get counter => _counter;

  // Setter
  set isTriggered(bool newValue){
    _isTriggered = newValue;
    notifyListeners();
  }
  set isBoomArmMenuOpened(bool newValue){
    _isBoomArmMenuOpened = newValue;
    notifyListeners();
  }

  set whichArm(double newValue){
    _whichArm = newValue;
    print(newValue);
    notifyListeners();
  }

  set leftArmStatus(double newValue){
    if (_leftArmStatus != newValue){
      print("LeftArm: $newValue");
      _leftArmStatus = newValue;
      notifyListeners();
    }
  }

  set rightArmStatus(double newValue){
    if (_rightArmStatus != newValue){
      print("RightArm: $newValue");
      _rightArmStatus = newValue;
      notifyListeners();
    }
  }

  set counter(double newValue){
    _counter = newValue;
    notifyListeners();
  }
}

class RobbyNotifier extends ChangeNotifier{
  // Initiate
  LatLng _robbyPosition = const LatLng(37.841945, 32.582772);
  late GoogleMapController _controller;
  double _currentMapBearing = 0;
  double _currentMapZoom = 19;

  // Getter
  LatLng get robbyPosition => _robbyPosition;
  GoogleMapController get controller => _controller;
  double get currentMapBearing => _currentMapBearing;
  double get currentMapZoom => _currentMapZoom;

  // Setter
  set robbyPosition(LatLng newValue){
    if (_robbyPosition != newValue){
      _robbyPosition = newValue;
      //controller.animateCamera(CameraUpdate.newLatLng(newValue));
      notifyListeners();
    }
  }

  set controller(GoogleMapController controller){
      _controller = controller;
      notifyListeners();
  }

  set currentMapBearing(double newValue){
    _currentMapBearing = newValue;
    notifyListeners();
  }

  set currentMapZoom(double newValue){
    _currentMapZoom = newValue;
    print(newValue);
    notifyListeners();
  }
}

class ConnectivityNotifier extends ChangeNotifier{
  // Initiator
  bool _isConnected2Net = false;

  // Getter
  bool get isConnected2Net => _isConnected2Net;

  // Setter
  set isConnected2Net(bool newValue){
    _isConnected2Net = newValue;
    notifyListeners();
  }
}