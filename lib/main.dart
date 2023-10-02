import 'package:flutter/material.dart';
import 'package:joystick_app/joystick.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Joystick',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Joystick App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedGallery = 0;
  int selectedImage = 0;
  List<List<String>> galleryList = [
    [
      "assets/birds/b1.jpg",
      "assets/birds/b2.jpg",
      "assets/birds/b3.jpg",
      "assets/birds/b4.jpg",
    ],
    [
      "assets/cats/c1.jpg",
      "assets/cats/c2.jpg",
      "assets/cats/c3.jpg",
      "assets/cats/c4.jpg",
    ],
    [
      "assets/dogs/d1.jpg",
      "assets/dogs/d2.jpg",
      "assets/dogs/d3.jpg",
      "assets/dogs/d4.jpg",
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              galleryList[selectedGallery][selectedImage],
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Joystick(
          backgroundColor: Colors.black,
          size: 100,
          opacity: 0,
          joystickMode: JoystickModes.all,
          iconColor: Colors.white,
          isDraggable: true,
          onUpPressed: () {
            if (selectedGallery - 1 >= 0) {
              setState(() {
                selectedGallery -= 1;
              });
            }
          },
          onLeftPressed: () {
            if (selectedImage - 1 >= 0) {
              setState(() {
                selectedImage -= 1;
              });
            }
          },
          onRightPressed: () {
            if (selectedImage + 1 < galleryList[selectedGallery].length) {
              setState(() {
                selectedImage += 1;
              });
            }
          },
          onDownPressed: () {
            if (selectedGallery + 1 < galleryList.length) {
              setState(() {
                selectedGallery += 1;
              });
            }
          },
          onPressed: (direction) {
            //print("pressed $_direction");
          },
        ),
      ),
    );
  }
}
