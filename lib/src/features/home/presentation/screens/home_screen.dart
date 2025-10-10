import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> pets = PetManager.instance.pets;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: pets.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 16), // space between cards
                itemBuilder: (context, index) {
                  final pet = pets[index];
                  return SizedBox(
                    width: 150, // fixed width per card
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                pet.imageUrl,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 60,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16.0, 8, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pet.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      pet.species.label,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("Heutiges Tagebuch"),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 30,
                  children: [
                    Text("Entry Placeholder"),
                    Row(
                      spacing: 30,
                      children: [
                        Image.network(pets[0].imageUrl, height: 100),
                        Column(children: [Text("Text1"), Text("Text 2")]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("Aktionen"),
            ),
            Row(
              spacing: 30,
              children: [
                Container(
                  height: 60,
                  width: 140,
                  color: Colors.red,
                  child: ListTile(
                    leading: Icon(Icons.book, size: 30),
                    title: Text("Tier anlegen"),
                  ),
                ),
                Container(
                  height: 60,
                  width: 150,
                  color: Colors.red,
                  child: ListTile(
                    leading: Icon(Icons.book, size: 30),
                    title: Text("Termin erstellen"),
                  ),
                ),
      
              ],
            ),
          ],
        ),
      ),
    );
  }
}
