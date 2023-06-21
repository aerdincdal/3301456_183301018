import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:world_time/themeNotifier.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:world_time/notifier_classes.dart';
import 'package:world_time/widgets/languageSelectionWidget.dart';
import 'package:world_time/widgets/worldTimeWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:world_time/widgets/robbyGenerator.dart';

class MonitorVehicle extends StatefulWidget {

  const MonitorVehicle({Key? key}) : super(key: key);

  @override
  State<MonitorVehicle> createState() => _MonitorVehicleState();
}

class _MonitorVehicleState extends State<MonitorVehicle> {

  final LatLng startingPosition = const LatLng(37.841945, 32.582772);
  final LatLng endingPosition = const LatLng(37.843534, 32.583024);

  late double robbyBearing;

  late GoogleMapController mapController;
  late BitmapDescriptor markerBitName;
  late Uint8List imageData = Uint8List(0);
  final LatLng _center = const LatLng(37.841945, 32.582772);

  Set<Marker> markers = {};



  void _onMapCreated(GoogleMapController controller) {
    final robbyNotifier = Provider.of<RobbyNotifier>(context, listen: false);
    robbyNotifier.controller = controller;
  }

  void _onCameraMove(CameraPosition cameraPosition){
    final robbyNotifier = Provider.of<RobbyNotifier>(context, listen: false);
    robbyNotifier.currentMapBearing =  cameraPosition.bearing;
    robbyNotifier.currentMapZoom = 156543.03392 * cos(cameraPosition.target.latitude * pi / 180) / pow(2, cameraPosition.zoom);
  }

  final Set<Polygon> _polygon =  HashSet<Polygon>();

  List<LatLng> points = [
    const LatLng(37.842118, 32.580945),
    const LatLng(37.841800, 32.583150),
    const LatLng(37.843655, 32.583438),
    const LatLng(37.843638, 32.581166),
  ];

  @override
  void initState() {
    super.initState();
    _polygon.add(
      Polygon(
        polygonId: const PolygonId('1'),
        points: points,
        fillColor: Colors.green.withOpacity(0.3),
        strokeColor: Colors.green,
        geodesic: true,
        strokeWidth: 4,
      )
    );

    double distanceLon = calculateDistance(startingPosition.latitude, startingPosition.longitude, startingPosition.latitude, endingPosition.longitude);
    double distanceLat = calculateDistance(startingPosition.latitude, startingPosition.longitude, endingPosition.latitude, startingPosition.longitude);

    robbyBearing = (atan2(distanceLon, distanceLat)) * 180 / pi;

    getBytesFromAsset('assets/topViewRobby.png', 300);
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    imageData = await (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  loadMarkerImage() async {
    markerBitName = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/topViewRobby.png',
    );
  }
  


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
                                  child: Consumer<RobbyNotifier>(
                                    builder: (context, robbyNotifier, _) => ElevatedButton(
                                      onPressed: () {
                                        robbyNotifier.currentMapZoom = 0.23579213886752606;
                                        robbyNotifier.currentMapBearing = 0;
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),
                                      child: Text(
                                        "<<BACK",
                                        style: TextStyle(
                                          color:
                                          themeSelector.homeTopBarLanguageColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                              Consumer<RobbyNotifier>(
                                builder: (context, robbyNotifier, _) =>
                                ElevatedButton(
                                  onPressed: () {
                                    robbyNotifier.currentMapZoom = 0.23579213886752606;
                                    robbyNotifier.currentMapBearing = 0;
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Text(
                                    "Home",
                                    style: TextStyle(
                                      color:
                                          themeSelector.homeTopBarMenuColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                    color:
                                        themeSelector.homeTopBarMenuColor,
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
                                    color:
                                        themeSelector.homeTopBarMenuColor,
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
                                        Provider.of<LanguageUpdater>(
                                                context,
                                                listen: false)
                                            .language = "TR";
                                        Provider.of<ThemeSelector>(context,
                                                listen: false)
                                            .themeSelection = 1;
                                      } else {
                                        Provider.of<LanguageUpdater>(
                                                context,
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
                      child: Stack(
                        children: <Widget> [
                          const GenerateRobby(),
                           FutureBuilder(
                            future: getBytesFromAsset('topViewRobby.png', 50),
                            builder:  (context, snapshot) {
                              if (!imageData.isEmpty) {
                                final robbyNotifier = Provider.of<RobbyNotifier>(context);
                                getBytesFromAsset('assets/topViewRobby.png', ( ( 0.2357921329422095 / robbyNotifier.currentMapZoom ) * 300 ).toInt());
                                markers.clear();
                                markers.add(
                                    Marker( //add start location marker
                                      icon: BitmapDescriptor.fromBytes(imageData),
                                      markerId: const MarkerId('robby'),
                                      position: robbyNotifier.robbyPosition, //position of markeror Marker
                                      rotation: (180 -robbyNotifier.currentMapBearing) + robbyBearing,
                                    )
                                );
                                return GoogleMap(
                                  mapType: MapType.satellite,
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: const CameraPosition(
                                    target: LatLng(37.841945, 32.582772),
                                    zoom: 19.0,
                                    bearing: 0,
                                  ),
                                  polygons: _polygon,
                                  markers: Set<Marker>.of(markers),
                                  onCameraMove: _onCameraMove,
                                  minMaxZoomPreference: const MinMaxZoomPreference(0, 19),
                                );
                              } else {
                                final robbyNotifier = Provider.of<RobbyNotifier>(context);
                                getBytesFromAsset('assets/topViewRobby.png', ( ( 0.2357921329422095 / robbyNotifier.currentMapZoom ) * 300 ).toInt());
                                return const Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator()
                                );// or some other placeholder
                              }
                            },
                          ),
                          /*IgnorePointer(
                            child: Align(
                              alignment: Alignment.center,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationZ(pi),
                                child: const Image(
                                  image: AssetImage(
                                    "assets/topViewRobby.png",
                                  ),
                                  width: 250,
                                ),
                              ),
                            ),
                          ),
                          */
                        ],
                      )
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
