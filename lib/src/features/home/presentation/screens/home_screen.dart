import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/home/presentation/widgets/pet_diary_entry.dart';
import 'package:pet_diary/src/features/home/presentation/widgets/pet_quick_action_button.dart';
import '../widgets/pet_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> pets = PetManager().pets;
  bool isDark = false;

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

                        return PetManager().pets
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
                    return Container(
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
                                  child: Icon(Icons.pest_control_rodent),
                                ),
                              ),
                              Text(PetType.values[index].label),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                itemCount: pets.length,
                itemBuilder: (context, index) {},
              ),
              ClipPath(
                clipper: CustomClipperShape(),
                child: Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(5),

                  // ),
                  color: Colors.red,
                  width: 180,
                  height: 180,
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
    // final path =
    //     Path() //! x = horizontal, y = vertical, startpunkt oben links
    //       ..moveTo(20, 0)
    //       ..quadraticBezierTo(0, 0, 0, 20)
    //       ..lineTo(0.0, size.height - 20) //!Linie nach unten
    //       ..quadraticBezierTo(0, size.height, 20, size.height)
    //       ..lineTo(
    //         size.width - size.width * 0.1,
    //         size.height,
    //       ) //!Linie nach ganz unten rechts
    //       ..quadraticBezierTo(
    //         size.width,
    //         size.height,
    //         size.width,
    //         size.height - size.height * 0.1,
    //       )
    //       //!Linie oben
    //       ..lineTo(size.width / 2 - 20, 0.0)
    //       ..close();

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
