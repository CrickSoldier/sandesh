import 'package:flutter/material.dart';
import 'slide_items.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        (index == 0)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Container(
                  width: 120,
                  height: 100,
                  margin: const EdgeInsets.only(left: 25.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage(slideList[index].imageUrl),
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
                child: Container(
                  width: 300,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage(slideList[index].imageUrl),
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 10, 10),
        ),
        (index == 0)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Text(
                  slideList[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 169, 80, 1),
                      fontSize: 35.0),
                ),
              )
            : Text(
                slideList[index].title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 169, 80, 1),
                    fontSize: 17.0),
              ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
          style:
              TextStyle(fontSize: 13, color: Color.fromRGBO(112, 112, 112, 1)),
        ),
      ],
    );
  }
}
