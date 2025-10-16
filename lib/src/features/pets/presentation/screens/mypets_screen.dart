import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/pets/presentation/screens/mypets_details_screen.dart';

class MyPetsScreen extends StatelessWidget {
  final List<Pet> pets = PetManager.instance.pets;
  MyPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = PetManager.instance.pets;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/manage_pets'),
          heroTag: null,
          child: Icon(Icons.add),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(title: Text("Tiertagebuch")),
            // Sticky Header
            SliverPersistentHeader(
              pinned: true, // bleibt oben sichtbar
              delegate: _MyHeaderDelegate(
                minHeight: 60,
                maxHeight: 60,
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Meine Haustiere",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            // Grid
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  Pet pet = pets[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyPetsDetailsScreen(
                              pet: pets[index],
                              index: index,
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 3 / 2,
                            child: Hero(
                              tag: 'tag_$index',
                              child: Image.network(
                                pet.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              pet.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    pet.species.label,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Text(
                                      '•',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${pet.age}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Text(
                                      '•',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${pet.weight}kg',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(pet.description),
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: pets.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Delegate für SliverPersistentHeader

  // return SingleChildScrollView(
  //   child: Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text("Meine Haustiere"),
  //       GridView.builder(
  //         shrinkWrap: true,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemCount: pets.length,
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           childAspectRatio: 0.8,
  //           crossAxisCount: 2,

  //         ),

  //         itemBuilder: (context, index) {
  //           Pet pet = pets[index];
  //           return Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: GestureDetector(
  //               onTap: () {
  //                 print('Card $index tapped');
  //               },
  //               child: Card(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     AspectRatio(
  //                       aspectRatio: 3 / 2,
  //                       child: Image.network(pet.imageUrl, fit: BoxFit.cover),
  //                     ),
  //                     Text(
  //                       pet.name,
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                     ),
  //                     FittedBox(
  //                       child: Row(
  //                         spacing: 5,
  //                         children: [
  //                           Text(
  //                             pet.species.label,
  //                             style: TextStyle(fontSize: 14, color: Colors.grey),
  //                           ),
  //                           Text(
  //                             '•',
  //                             style: TextStyle(fontSize: 18, color: Colors.grey),
  //                           ),
  //                           Text(
  //                             '${pet.age}',
  //                             style: TextStyle(fontSize: 14, color: Colors.grey),
  //                           ),
  //                           Text(
  //                             '•',
  //                             style: TextStyle(fontSize: 18, color: Colors.grey),
  //                           ),
  //                           Text(
  //                             '${pet.weight}kg',
  //                             style: TextStyle(fontSize: 14, color: Colors.grey),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Text(pet.description),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ],
  //   ),
  // );
}

class _MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _MyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
