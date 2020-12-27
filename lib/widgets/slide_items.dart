import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/sandesh.png',
    title: 'Welcome \n to \n Sandesh',
    description: '',
  ),
  Slide(
    imageUrl: 'assets/images/newimg.jpg',
    title:
        'LEAD India (Leadership for Environment and Development) is an international network of LEADers. Our purpose is to build leaders who become the catalyst for change',
    description: '',
  ),
  Slide(
    imageUrl: 'assets/images/second.jpg',
    title: 'Take people along- build ready & resilient communities',
    description: '',
  ),
  Slide(
    imageUrl: 'assets/images/2.png',
    title: 'Walk with love,\n Act in kindness, \n See oneness',
    description: '',
  ),
  Slide(
    imageUrl: 'assets/images/3.jpg',
    title: 'Sense "rhythm" of the system \n it'
        "'s interconnections and leverages",
    description: '',
  ),
  Slide(
    imageUrl: 'assets/images/4.jpg',
    title: 'Validate information; \n Share knowledge; \n Honour wisdom',
    description: '',
  ),
];
