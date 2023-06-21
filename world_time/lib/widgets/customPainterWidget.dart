import 'package:flutter/material.dart';
import 'package:world_time/notifier_classes.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:arrow_path/arrow_path.dart';
import 'package:world_time/themeNotifier.dart';

class ArrowPainter extends CustomPainter{

  double width;
  double height;
  bool isHorizontal;
  ThemeSelector themeSelector;

  ArrowPainter(this.width, this.height, this.isHorizontal, this.themeSelector);

  @override
  void paint(Canvas canvas, Size size){

    final Paint paint = Paint()
      ..color = themeSelector.homeConnectionStatusColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2.0;

      Path path = Path();
      if (isHorizontal) {
        path.moveTo(width * 0.25 - 165, -75);
        path.relativeCubicTo(0, 0, width * 0.25, 0, width * 0.5, 0);
      }
      else{
        path.moveTo(width * 0.25 + 220, -235);
        path.relativeCubicTo(0, width * 0.25, 0, 0, 0, width * 0.5);
      }
      path = ArrowPath.addTip(path, tipAngle: 0.3, tipLength: 10,);
      path = ArrowPath.addTip(path, isBackward: true, tipAngle: 0.3, tipLength: 10,);

      canvas.drawPath(path, paint..color = themeSelector.homeTopLineColor,);

      if (isHorizontal) {
        TextSpan textSpan = TextSpan(
          text: 'Track Width',
          style: TextStyle(color: themeSelector.homeConnectionStatusColor,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            backgroundColor: themeSelector.homeGeneralBackgroundColor,),
        );
        final TextPainter textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(minWidth: width);
        textPainter.paint(canvas, const Offset(-165, -83));
      } else {
        TextSpan textSpan = TextSpan(
          text: 'Chassis\nHeight',
          style: TextStyle(color: themeSelector.homeConnectionStatusColor,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            backgroundColor: themeSelector.homeGeneralBackgroundColor,),
        );
        final TextPainter textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(minWidth: width);
        textPainter.paint(canvas, const Offset(175, -205));
      }
  }

  @override
  bool shouldRepaint(covariant ArrowPainter oldDelegate) {
    return true;
  }
}

class CloseButtonLinePainter extends CustomPainter{

  Offset startingPoint;
  Offset secondPoint;
  double endLength;
  ThemeSelector themeSelector;
  bool isRight;

  CloseButtonLinePainter(this.startingPoint, this.secondPoint, this.endLength, this.isRight,this.themeSelector);

  @override
  void paint(Canvas canvas, Size size){

    Paint paint = Paint()
      ..strokeWidth = 2
      ..color = themeSelector.homeConnectionStatusColor;

    canvas.drawLine(startingPoint, secondPoint, paint);
    if (isRight){
      canvas.drawLine(secondPoint, Offset(secondPoint.dx + endLength, secondPoint.dy), paint);
    } else {
      canvas.drawLine(secondPoint, Offset(secondPoint.dx - endLength, secondPoint.dy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CloseButtonLinePainter oldDelegate) {
    return true;
  }
}

class SideWayDashedLinePainter extends CustomPainter{
  ThemeSelector themeSelector;

  ExpansionNotifier expansionNotifier;
  double width;
  double heightDifference;
  late Offset firstStartingPoint;
  late Offset secondStartingPoint;
  late Offset firstEndPoint;
  late Offset secondEndPoint;

  SideWayDashedLinePainter(this.firstStartingPoint, this.width , this.heightDifference, this.expansionNotifier, this.themeSelector);


  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5;
    secondStartingPoint = Offset(firstStartingPoint.dx, firstStartingPoint.dy + heightDifference);
    firstEndPoint = Offset(firstStartingPoint.dx  + (width * ( expansionNotifier.counter / 100)) , firstStartingPoint.dy);
    secondEndPoint = Offset(secondStartingPoint.dx + (width * (expansionNotifier.counter / 100)), secondStartingPoint.dy);

    double firstLineReference = firstStartingPoint.dx;

    final firstPaint = Paint()
      ..color = themeSelector.homeTopLineColor
      ..strokeWidth = 2;


    final secondPaint = Paint()
      ..color = themeSelector.homeTopLineColor
      ..strokeWidth = 3;


    while (firstLineReference < firstEndPoint.dx) {
      canvas.drawLine(Offset(firstLineReference, firstStartingPoint.dy), Offset(firstLineReference + dashWidth, firstEndPoint.dy), firstPaint);
      canvas.drawLine(Offset(firstLineReference, secondStartingPoint.dy), Offset(firstLineReference + dashWidth, secondEndPoint.dy), firstPaint);
      firstLineReference += dashWidth + dashSpace;
    }

    if (expansionNotifier.counter == 100){
      canvas.drawLine(Offset(firstStartingPoint.dx + (firstEndPoint.dx - firstStartingPoint.dx) * 1 / 5, firstStartingPoint.dy - (expansionNotifier.escalation) * 37 / 20 ), Offset(firstEndPoint.dx - (firstEndPoint.dx - firstStartingPoint.dx) * 1 / 5, firstStartingPoint.dy - (expansionNotifier.escalation) * 37 / 20 ), secondPaint );
    }
  }

  @override
  bool shouldRepaint(covariant SideWayDashedLinePainter oldDelegate) {
    return true;
  }

}

class DashedLinePainter extends CustomPainter {

  ThemeSelector themeSelector;

  ExpansionNotifier expansionNotifier;
  double height;
  late Offset firstStartingPoint;
  late Offset secondStartingPoint;
  late Offset firstEndPoint;
  late Offset secondEndPoint;


  DashedLinePainter(this.firstStartingPoint, this.height ,this.expansionNotifier, this.themeSelector);

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5;
    secondStartingPoint = Offset(firstStartingPoint.dx + size.width, firstStartingPoint.dy);
    firstEndPoint = Offset(firstStartingPoint.dx, firstStartingPoint.dy + (height * ( expansionNotifier.counter / 100)));
    secondEndPoint = Offset(secondStartingPoint.dx, secondStartingPoint.dy + (height * (expansionNotifier.counter / 100)));

    double firstLineReference = firstStartingPoint.dy;

    final firstPaint = Paint()
      ..color = themeSelector.homeTopLineColor
      ..strokeWidth = 2;

    final secondPaint = Paint()
      ..color = themeSelector.homeTopLineColor
      ..strokeWidth = 2;

    while (firstLineReference < firstEndPoint.dy) {
      canvas.drawLine(Offset(firstStartingPoint.dx, firstLineReference), Offset(firstEndPoint.dx, firstLineReference + dashWidth), firstPaint);
      canvas.drawLine(Offset(secondStartingPoint.dx, firstLineReference), Offset(secondEndPoint.dx, firstLineReference + dashWidth), secondPaint);
      firstLineReference += dashWidth + dashSpace;
    }

    if (expansionNotifier.counter == 100) {
      canvas.drawLine(Offset(secondStartingPoint.dx + ( expansionNotifier.trackLength - 39 ), secondStartingPoint.dy + (secondEndPoint.dy - secondStartingPoint.dy) * 1 / 5  ), Offset(secondStartingPoint.dx + ( expansionNotifier.trackLength - 39 ), secondEndPoint.dy - (secondEndPoint.dy - secondStartingPoint.dy) * 1 / 5 ), secondPaint );
      canvas.drawLine(Offset(firstStartingPoint.dx - ( expansionNotifier.trackLength - 39 ), secondStartingPoint.dy + (secondEndPoint.dy - secondStartingPoint.dy) * 1 / 5  ), Offset(firstStartingPoint.dx - ( expansionNotifier.trackLength - 39 ), secondEndPoint.dy - (secondEndPoint.dy - secondStartingPoint.dy) * 1 / 5 ), secondPaint );

    }
  }

  @override
  bool shouldRepaint(covariant DashedLinePainter oldDelegate) {
    return true;
  }
}

class MyPainter extends CustomPainter {
  dynamic p2;
  dynamic p4;
  final Offset _startingFirst;
  final Offset _startingSecond;
  ThemeSelector themeSelector;

  MyPainter(double off_set, this._startingFirst, this._startingSecond,
      bool isRight, int sequence, this.themeSelector) {
    if (off_set >= sequence * 100 && off_set <= sequence * 100 + 100) {
      p2 = Offset(
          _startingFirst.dx +
              ((_startingSecond.dx - _startingFirst.dx) * off_set) / 100,
          _startingFirst.dy -
              ((_startingFirst.dy - _startingSecond.dy) * off_set) / 100);
    } else {
      p2 = Offset(
          _startingFirst.dx +
              ((_startingSecond.dx - _startingFirst.dx) * 100) / 100,
          _startingFirst.dy -
              ((_startingFirst.dy - _startingSecond.dy) * 100) / 100);
    }
    if (isRight) {
      if (off_set >= (sequence + 1) * 100 &&
          off_set <= (sequence + 1) * 100 + 100) {
        p4 = Offset(
            _startingSecond.dx + ((off_set - (sequence + 1) * 100) * 6 / 3),
            _startingSecond.dy);
      } else {
        p4 = Offset(_startingSecond.dx, _startingSecond.dy);
      }
    } else {
      if (off_set >= (sequence + 1) * 100 &&
          off_set <= (sequence + 1) * 100 + 100) {
        p4 = Offset(
            _startingSecond.dx - ((off_set - (sequence + 1) * 100) * 6 / 3),
            _startingSecond.dy);
      } else {
        p4 = Offset(_startingSecond.dx, _startingSecond.dy);
      }
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = _startingFirst;
    final p3 = _startingSecond;

    final Color colorShiner = themeSelector.homeTopLineColor;
    final paint2 = Paint()
      ..color = colorShiner
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint2);

    final Color colorStrangeGrey = themeSelector.homeTopLineColor;
    final paint = Paint()
      ..color = colorStrangeGrey
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);

    final paint4 = Paint()
      ..color = colorShiner
      ..strokeWidth = 1;
    canvas.drawLine(p3, p4, paint4);

    final paint3 = Paint()
      ..color = colorStrangeGrey
      ..strokeWidth = 5;
    if (p4.dx > _startingSecond.dx + 75) {
      canvas.drawLine(Offset(_startingSecond.dx + 75, p3.dy), p4, paint3);
    }
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.p2 != p2 || oldDelegate.p4 != p4;
  }
}

class CirclePainter extends CustomPainter {
  final double _strokeWidth;
  late final Paint _paint;
  double offSet_dx;
  double offSet_dy;
  ThemeSelector themeSelector;
  IconData iconData;
  Color? iconColor;

  CirclePainter(
      this._strokeWidth, this.offSet_dx, this.offSet_dy, this.themeSelector,
      [this.iconData = Icons.abc]) {
    _paint = Paint()
      ..color = themeSelector.homeSmallCircleColor
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(offSet_dx, offSet_dy, size.width, size.height),
      _paint,
    );
    double blurRadius = 2;
    if (iconData != Icons.abc) {
      if (iconData == PhosphorIcons.regular.headlights) {
        iconColor = themeSelector.homeHeadlightIconColor;
        if (themeSelector.isHeadlightOn) {
          blurRadius = 10;
        }
      } else {
        iconColor = themeSelector.homeMenuSubButtonColor;
      }

      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          fontSize: size.width * 4 / 5, // Adjust the size of the icon as needed
          color: iconColor, // Choose the color of your icon
          fontFamily: iconData.fontFamily,
          shadows: [
            Shadow(
                color: themeSelector.homeMenuSubButtonColor,
                blurRadius: blurRadius)
          ],
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              offSet_dx + size.width * 1 / 9, offSet_dy + size.width * 1 / 10));
    }
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) {
    return true;
  }
}

class MainMenuPainter extends CustomPainter {
  ThemeSelector themeSelector;

  MainMenuPainter(this.themeSelector);

  @override
  void paint(Canvas canvas, Size size) {
    const p1 = Offset(0, 42);
    const p2 = Offset(120, 42);
    const p3 = Offset(120, 42);
    const p4 = Offset(156, 14);

    final Color colorStrangeGrey = themeSelector.homeTopLineColor;
    final paint = Paint()
      ..color = colorStrangeGrey
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);

    final paint3 = Paint()
      ..color = colorStrangeGrey
      ..strokeWidth = 1;
    canvas.drawLine(p3, p4, paint3);
  }

  @override
  bool shouldRepaint(covariant oldDelegate) {
    return false;
  }
}