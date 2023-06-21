import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> uploadDataFromSQLiteToFirebaseBoom() async {
  Database db = await openDatabase(
    join(await getDatabasesPath(), 'robot_database.db'),
  );

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var data = await db.query('boomStatus');
  for (var row in data) {
    firestore.collection("RobotTest").add(row).then((DocumentReference doc) => print("Boom status added to DB. [${doc.id}]"));
    await db.delete('boomStatus', where: 'timeStamp = ?', whereArgs: [row['timeStamp']]);
  }

  data = await db.query('expansionStatus');
  for (var row in data) {
    firestore.collection("RobotTest").add(row).then((DocumentReference doc) => print("Expansion status added to DB. [${doc.id}]"));
    await db.delete('expansionStatus', where: 'timeStamp = ?', whereArgs: [row['timeStamp']]);
  }

  data = await db.query('applicationStarted');
  for (var row in data) {
    firestore.collection("RobotTest").add(row).then((DocumentReference doc) => print("Application started log added to DB. [${doc.id}]"));
    await db.delete('applicationStarted', where: 'timeStamp = ?', whereArgs: [row['timeStamp']]);
  }


}

void boomDBUpdate(double leftArmStatus, double rightArmStatus, bool connectionStatus) async {

  String leftArm;
  switch (leftArmStatus){
    case 0:
      leftArm = "Close";
      break;
    case 1:
      leftArm = "Semi-Open";
      break;
    case 2:
      leftArm = "Open";
      break;
    default:
      leftArm = "Undefined Error!";
      break;
  }

  String rightArm;
  switch (rightArmStatus){
    case 0:
      rightArm = "Close";
      break;
    case 1:
      rightArm = "Semi-Open";
      break;
    case 2:
      rightArm = "Open";
      break;
    default:
      rightArm = "Undefined Error!";
      break;
  }

  final data = <String, dynamic>{
    'timeStamp' : DateTime.now().toString(),
    'leftBoomStatus': leftArm,
    'rightBoomStatus': rightArm,
  };

  if (connectionStatus){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("RobotTest").add(data).then((DocumentReference doc) => print("Boom status added to DB. [${doc.id}]"));

    await uploadDataFromSQLiteToFirebaseBoom();
  }
  else{
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'robot_database.db'),
    );

    var tableExists = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='boomStatus'");

    if (tableExists.isEmpty) {
      await db.execute(
        "CREATE TABLE boomStatus(timeStamp TEXT PRIMARY KEY, leftBoomStatus TEXT, rightBoomStatus TEXT)",
      );
    }

    await db.insert('boomStatus', data);
    print("Boom status is written to local DB!");
  }
}

void expansionDBUpdate(double trackWidth, double chassisHeight, bool connectionStatus) async {

  final data = <String, dynamic>{
    'timeStamp' : DateTime.now().toString(),
    'trackWidth': trackWidth,
    'chassisHeight': chassisHeight,
  };

  if (connectionStatus){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("RobotTest").add(data).then((DocumentReference doc) => print("Expansion status added to DB. [${doc.id}]"));

    await uploadDataFromSQLiteToFirebaseBoom();
  }
  else{
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'robot_database.db'),
    );

    var tableExists = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='expansionStatus'");

    if (tableExists.isEmpty) {
      await db.execute(
        "CREATE TABLE expansionStatus(timeStamp TEXT PRIMARY KEY, trackWidth REAL, chassisHeight REAL)",
      );
    }
    await db.insert('expansionStatus', data);
    print("Expansion status is written to local DB!");
  }
}

void onAppStartDBUpdate(bool connectionStatus) async {

  final data = <String, dynamic>{
    'timeStamp' : DateTime.now().toString(),
    'applicationStarted' : true,
  };
  if (connectionStatus){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("RobotTest").add(data).then((DocumentReference doc) => print("Application started log added to DB. [${doc.id}]"));

    await uploadDataFromSQLiteToFirebaseBoom();
  }
  else{
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'robot_database.db'),
    );

    var tableExists = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='applicationStarted'");

    if (tableExists.isEmpty) {
      await db.execute(
        "CREATE TABLE applicationStarted(timeStamp TEXT PRIMARY KEY, applicationStarted INTEGER)",
      );
    }

    await db.insert('applicationStarted', data);
    print("Application started log is written to local DB!");
  }
}

