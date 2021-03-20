import 'package:flutter/material.dart';

class _BackgroundClipper extends CustomClipper<Path> {
  final double div;
  final bool upDown;
  _BackgroundClipper({this.div, this.upDown});

  @override
  Path getClip(Size size) {
    final k = 5;
    final path = Path()
      ..moveTo(0, size.height * (div - 1) / div)
      ..quadraticBezierTo(
        size.width / 2,
        size.height * (div + k - 1) / (div + k),
        size.width,
        size.height * (div - 1) / div,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    if (this.upDown) {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height / div)
        ..quadraticBezierTo(
          size.width / 2,
          size.height / (div + k),
          0,
          size.height / div,
        )
        ..close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Background extends StatelessWidget {
  final double div;
  final bool drawUpDown;

  const Background({
    Key key,
    this.div = 5,
    this.drawUpDown = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _BackgroundClipper(div: div, upDown: drawUpDown),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        color: Color(0xff80AF08),
        width: double.maxFinite,
        height: double.maxFinite,
      ),
    );
  }
}
