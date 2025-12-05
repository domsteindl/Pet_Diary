import 'package:flutter/material.dart';
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/hive_service.dart';
import 'package:pet_diary/src/core/services/supabase_service.dart';
import 'package:pet_diary/src/features/pets/data/remote/pet_remote_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwapped = false;
  List<Pet> pets = HiveService.getAllPets();
  late Future<List<Pet>> petsRemote;
  PetRemoteRepository remoteRepo = PetRemoteRepository(SupabaseService.client);
  bool isDark = false;
  final int _currentPetIndex = 0;

  @override
  void initState() {
    super.initState();
    petsRemote = remoteRepo.getAllPets();
  }

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tiertagebuch")),
      body: Column(
        children: [
          FutureBuilder(
            future: petsRemote,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const .all(16.0),
                    child: Text(
                      "Fehler beim Laden der Tiere: ${snapshot.error.toString()}",
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                final pets = snapshot.data ?? [];

                if (pets.isEmpty) {
                  return const Center(
                    child: Text("Noch keine Tiere angelegt!"),
                  );
                }
                final normalPets = pets
                    .where((pet) => pet.isAquatic == false)
                    .toList();
                final aquaticPets = pets
                    .where((pet) => pet.isAquatic == true)
                    .toList();

                return Column(
                  spacing: 20,
                  children: [
                    const Text("Meine Haustiere"),
                    PetList(title: "Haustiere", pets: normalPets),
                    const Text("Aquatische Tiere"),
                    PetList(title: "Aquatische Tiere", pets: aquaticPets),
                  ],
                );
              }
              return const Center(child: Text("Startbildschirm"));
            },
          ),
        ],
      ),
    );
  }
}

class PetList extends StatelessWidget {
  final String title;
  final List<Pet> pets;
  const PetList({super.key, required this.title, required this.pets});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        itemCount: pets.length,
        scrollDirection: .horizontal,
        itemBuilder: (context, index) {
          final currentPet = pets[index];
          return Padding(
            padding: const .all(16.0),
            child: PetCard(pet: currentPet),
          );
        },
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;
  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    // Example UI based on the design concepts (Green/White theme)
    return SizedBox(
      width: 140,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder for an image or icon
              Icon(
                pet.species == PetType.dog
                    ? Icons.pets
                    : pet.species == PetType.cat
                    ? Icons.pets
                    : Icons.local_dining,
                color: pet.species == PetType.dog ? Colors.orange : Colors.blue,
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(
                pet.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF4CAF50),
                ),
              ),
              Text(
                pet.species.name,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
