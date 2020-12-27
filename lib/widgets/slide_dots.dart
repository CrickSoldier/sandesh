import 'package:flutter/material.dart';

class SlideDots extends StatefulWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  _SlideDotsState createState() => _SlideDotsState();
}

class _SlideDotsState extends State<SlideDots> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: widget.isActive ? 12 : 12,
      width: widget.isActive ? 12 : 12,
      decoration: BoxDecoration(
        color: widget.isActive
            ? Color.fromRGBO(0, 169, 80, 1)
            : Color.fromRGBO(202, 202, 202, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );
  }
}
