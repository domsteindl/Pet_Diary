import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/hive_service.dart';
import 'package:pet_diary/src/core/services/supabase_service.dart';
import 'package:pet_diary/src/features/pets/data/remote/pet_remote_repository.dart';
import 'package:timelines_plus/timelines_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwapped = false;
  List<Pet> pets = HiveService.getAllPets();
  late Stream<List<Pet>> petsRemote;
  PetRemoteRepository remoteRepo = PetRemoteRepository(SupabaseService.client);
  bool isDark = false;

  Stream<List<Pet>> getAllPetsStream() {
    return SupabaseService.client
        .from('pets')
        .stream(primaryKey: ['id'])
        // ID als PrimaryKey
        .map((eventList) => eventList.map((map) => Pet.fromMap(map)).toList());
  }

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    final titleText = !isSwapped ? "Tiertagebuch" : "Aquaristik & Co.";
    final buttonText = !isSwapped ? "Aquaristik & Co." : "Tiertagebuch";
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        actions: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                isSwapped = !isSwapped;
              });
            },
            icon: const Icon(Icons.swap_horiz, color: Colors.white),
            label: Text(
              buttonText,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: getAllPetsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Fehler: ${snapshot.error}');
          } else {
            final petsRemote = snapshot.data!;
            return Column(
              children: [
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(8),
                  color: Colors.blueGrey,
                  width: double.infinity,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {},
                    itemCount: petsRemote.length,
                    itemBuilder: (context, index) {
                      return PetCard(pet: petsRemote[index]);
                    },
                  ),
                ),
                Expanded(
                  child: Timeline.tileBuilder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    builder: TimelineTileBuilder(
                      contentsBuilder: (context, index) {
                        return Center(
                          child: TimeLineEntry(petsRemote[index].name, index),
                        );
                      },
                      contentsAlign: ContentsAlign.alternating,
                      startConnectorBuilder: (context, index) =>
                          const SolidLineConnector(),
                      endConnectorBuilder: (context, index) =>
                          const SolidLineConnector(),
                      indicatorBuilder: (context, index) =>
                          const DotIndicator(),

                      itemCount: petsRemote.length,
                      itemExtent: 200,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
      // FutureBuilder<List<Pet>>(
      //   future: fetchPets(),
      //   builder: (context, snapshot) {

      //   },
      // ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       "Tiertagebuch",
    //       style: Theme.of(context).textTheme.titleLarge,
    //     ),
    //     elevation: 3,
    //   ),

    //   body: SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Row(
    //             spacing: 30,
    //             children: [
    //               SizedBox(
    //                 width: 280,
    //                 child: SearchAnchor.bar(
    //                   suggestionsBuilder: (context, controller) {
    //                     final String input = controller.text;

    //                     return pets
    //                         .where(
    //                           (Pet pet) => pet.species.label.contains(input),
    //                         )
    //                         .map((e) => Text(e.name))
    //                         .toList();
    //                   },
    //                   barHintText: 'Suche...',
    //                 ),
    //               ),
    //               GestureDetector(
    //                 onTap: () => print("tapped"),
    //                 child: Container(
    //                   height: 60,
    //                   width: 60,
    //                   decoration: BoxDecoration(
    //                     color: Colors.black,
    //                     borderRadius: BorderRadius.circular(30),
    //                   ),
    //                   child: Icon(Icons.filter_alt, color: Colors.white),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [Text("Kategorie"), Text("Alle anzeigen")],
    //           ),
    //           SizedBox(
    //             height: 155,
    //             child: ListView.builder(
    //               scrollDirection: Axis.horizontal,
    //               itemCount: PetType.values.length,

    //               itemBuilder: (context, index) {
    //                 return GestureDetector(
    //                   onTap: () => setState(() {
    //                     selectedIndex = index;
    //                   }),
    //                   child: Container(
    //                     padding: const EdgeInsets.all(6.0),
    //                     child: Card(
    //                       elevation: 3,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadiusGeometry.circular(50),
    //                       ),
    //                       child: AspectRatio(
    //                         aspectRatio: 3 / 4,
    //                         child: Column(
    //                           spacing: 10,
    //                           children: [
    //                             Padding(
    //                               padding: const EdgeInsets.only(top: 10.0),
    //                               child: Container(
    //                                 height: 60,
    //                                 width: 60,
    //                                 decoration: BoxDecoration(
    //                                   color: Colors.white,
    //                                   borderRadius: BorderRadius.circular(30),
    //                                 ),
    //                                 child: Icon(
    //                                   color: selectedIndex == index
    //                                       ? Colors.orange
    //                                       : Colors.black,
    //                                   Icons.pest_control_rodent,
    //                                 ),
    //                               ),
    //                             ),
    //                             Text(PetType.values[index].label),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //           SizedBox(
    //             height: 250,
    //             child: ListView.builder(
    //               itemCount: pets.length,
    //               scrollDirection: Axis.horizontal,
    //               itemBuilder: (context, index) {
    //                 Pet pet = pets[index];
    //                 final textPainter = TextPainter(
    //                   text: TextSpan(text: pet.name),
    //                   textDirection: TextDirection.ltr,
    //                 )..layout();

    //                 final textWidth = textPainter.width;
    //                 return Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 32.0),
    //                   child: Stack(
    //                     clipBehavior: Clip.none,
    //                     alignment: Alignment.centerLeft,
    //                     children: [
    //                       ClipPath(
    //                         clipper: CustomClipperShape(),
    //                         child: Container(
    //                           color: const Color.fromARGB(255, 216, 214, 175),
    //                           width: 180,
    //                           height: 180,
    //                         ),
    //                       ),

    //                       Positioned(
    //                         top: 90,
    //                         left: -20,
    //                         child: Transform(
    //                           alignment: Alignment.topLeft,
    //                           transform: Matrix4.identity()
    //                             ..rotateZ(-pi / 2)
    //                             ..translateByVector3(
    //                               vmath.Vector3(-textWidth + 40, 0, 0),
    //                             ), // TextWidth messen
    //                           child: Text(pet.name),
    //                         ),
    //                       ),
    //                       Positioned(
    //                         top: 50,
    //                         child: Text('Typ: ${pet.species.label}'),
    //                       ),
    //                       Positioned.fill(
    //                         top: 40,
    //                         left: 40,
    //                         child: SvgPicture.asset(pet.species.imagePath),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;
  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.white]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: Image.network(
                "https://plus.unsplash.com/premium_photo-1667030474693-6d0632f97029?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2F0fGVufDB8fDB8fHww", // z. B. pet.imagePath
                height: double.maxFinite,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pet.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${pet.age} Jahre",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  pet.species.label,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipperShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final height = size.height;
    const double r = 35.0; // aller ecken;
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

class TimeLineEntry extends StatelessWidget {
  final String name;
  final int index;
  const TimeLineEntry(this.name, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.6),
          width: 1.5,
        ),
      ),
      height: double.infinity,
      width: 200,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  blurStyle: BlurStyle.solid,
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () => print("tapped $index"),
              child: Hero(
                tag: "Bild $index",
                child: Image.network(
                  "https://www.newyorkinfo.nl/wp-content/uploads/2025/01/parken-in-New-York-scaled.webp",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Walk in the park",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Here will be written a short description of the Diary Entry. Further Details when clicking on the picture",
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
