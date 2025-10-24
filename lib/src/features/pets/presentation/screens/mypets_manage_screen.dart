import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';

class MypetsManageScreen extends StatefulWidget {
  const MypetsManageScreen({super.key});

  @override
  State<MypetsManageScreen> createState() => _PetManageScreenState();
}

class _PetManageScreenState extends State<MypetsManageScreen> {
  List<Pet> pets = PetManager().pets;

  void _deletePet(Pet pet) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Haustier löschen"),
        content: Text("Willst du ${pet.name} wirklich löschen?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Abbrechen"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                pets.remove(pet);
              });
              Navigator.of(context).pop();
            },
            child: const Text("Löschen"),
          ),
        ],
      ),
    );
  }

  // void _editPet(Pet pet) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => ManagePetFormScreen(pet: pet),
  //     ),
  //   );
  //   setState(() {});
  // }

  // void _createPet() async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => const ManagePetFormScreen(),
  //     ),
  //   );
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        heroTag: null,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: 100,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
              elevation: 3,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text("Haustiere verwalten"),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final pet = pets[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 3 / 2,
                          child: Image.network(pet.imageUrl, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            pet.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            pet.species.label,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => (),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deletePet(pet),
                            ),
                          ],
                        ),
                      ],
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
}
