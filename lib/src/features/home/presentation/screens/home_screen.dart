import 'dart:math';

import 'package:pet_diary/src/core/services/hive_service.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/pet.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> pets = HiveService.getAllPets();
  bool isDark = false;

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tiertagebuch",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 3,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                spacing: 30,
                children: [
                  SizedBox(
                    width: 280,
                    child: SearchAnchor.bar(
                      suggestionsBuilder: (context, controller) {
                        final String input = controller.text;

                        return pets
                            .where(
                              (Pet pet) => pet.species.label.contains(input),
                            )
                            .map((e) => Text(e.name))
                            .toList();
                      },
                      barHintText: 'Suche...',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print("tapped"),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.filter_alt, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Kategorie"), Text("Alle anzeigen")],
              ),
              SizedBox(
                height: 155,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: PetType.values.length,

                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        selectedIndex = index;
                      }),
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(50),
                          ),
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Column(
                              spacing: 10,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Icon(
                                      color: selectedIndex == index
                                          ? Colors.orange
                                          : Colors.black,
                                      Icons.pest_control_rodent,
                                    ),
                                  ),
                                ),
                                Text(PetType.values[index].label),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: pets.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Pet pet = pets[index];
                    final textPainter = TextPainter(
                      text: TextSpan(text: pet.name),
                      textDirection: TextDirection.ltr,
                    )..layout();

                    final textWidth = textPainter.width;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.centerLeft,
                        children: [
                          ClipPath(
                            clipper: CustomClipperShape(),
                            child: Container(
                              color: const Color.fromARGB(255, 216, 214, 175),
                              width: 180,
                              height: 180,
                            ),
                          ),

                          Positioned(
                            top: 90,
                            left: -20,
                            child: Transform(
                              alignment: Alignment.topLeft,
                              transform: Matrix4.identity()
                                ..rotateZ(-pi / 2)
                                ..translateByVector3(
                                  vmath.Vector3(-textWidth + 40, 0, 0),
                                ), // TextWidth messen
                              child: Text(pet.name),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            child: Text('Typ: ${pet.species.label}'),
                          ),
                          Positioned.fill(
                            top: 40,
                            left: 40,
                            child: SvgPicture.asset(pet.species.imagePath),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomClipperShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    final w = size.width;
    final height = size.height;
    final double r = 35.0; // aller ecken;
    // Einheitsvektor entlang der Diagonale (von Knick w/2,0 nach w,height)
    final dx = w - w / 2;
    final dy = height - 0;
    final len = sqrt(dx * dx + dy * dy);
    final ux = dx / len;
    final uy = dy / len;
    final path = Path()
      ..moveTo(20, 0)
      ..quadraticBezierTo(0, 0, 0, 20)
      ..lineTo(0.0, height - 20)
      ..quadraticBezierTo(0, size.height, 20, size.height)
      ..lineTo(w - r, height)
      ..moveTo(20, 0.0)
      ..lineTo(w / 2 - r, 0)
      ..quadraticBezierTo(w / 2, 0, w / 2 + r * ux, r * uy)
      ..lineTo(w - r * ux, height - r * uy)
      ..quadraticBezierTo(w, height, w - r, height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
