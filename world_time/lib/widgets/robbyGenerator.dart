import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:world_time/notifier_classes.dart';

class GenerateRobby extends StatefulWidget {
  const GenerateRobby({Key? key}) : super(key: key);

  @override
  State<GenerateRobby> createState() => _GenerateRobbyState();
}

class _GenerateRobbyState extends State<GenerateRobby> with SingleTickerProviderStateMixin {


  final LatLng startingPosition = const LatLng(37.841945, 32.582772);
  final LatLng endingPosition = const LatLng(37.843534, 32.583024);

  final double minimumAllowedUpdate = 0;

  AnimationController? robbyAnimationController;
  Animation<double>? robbyAnimation;


  @override
  void initState(){
    super.initState();

    double oldAnimationValue = 0;

    robbyAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    robbyAnimation = CurvedAnimation(parent: robbyAnimationController!, curve: Curves.linear)
      ..addListener(() {
        final robbyNotifier = Provider.of<RobbyNotifier>(context, listen: false);
        double currentLat = startingPosition.latitude + (endingPosition.latitude - startingPosition.latitude) * robbyAnimationController!.value;
        double currentLon = startingPosition.longitude + (endingPosition.longitude - startingPosition.longitude) * robbyAnimationController!.value;
        if (robbyAnimationController!.value - oldAnimationValue > minimumAllowedUpdate) {
          oldAnimationValue = robbyAnimationController!.value;
          robbyNotifier.robbyPosition = LatLng(currentLat, currentLon);
        }
        if (robbyAnimationController!.value == 1.0){
          oldAnimationValue = 0;
          stopRobbyAnimation();
        }
      }
      );
    startRobbyAnimation();
  }

  void startRobbyAnimation(){
    robbyAnimationController!.forward(from: 0);
  }

  void stopRobbyAnimation(){
    robbyAnimationController!.stop();
    startRobbyAnimation();
  }

  @override
  void dispose(){
    robbyAnimationController!.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


