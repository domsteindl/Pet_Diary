import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_diary/src/core/enums/pet_type.dart';
import 'package:pet_diary/src/core/models/cat.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/home/presentation/screens/home_screen.dart';


class PetAddScreen extends StatefulWidget {
  const PetAddScreen({super.key});

  @override
  State<PetAddScreen> createState() => _PetAddScreenState();
}

class _PetAddScreenState extends State<PetAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  PetType _selectedType = PetType.cat;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    loadRandomImage();
  }

  Future<void> loadRandomImage() async {
    final url = Uri.parse('https://random.dog/woof.json?ref=public_apis');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _imageUrl = data['url'];
        });
      }
    } catch (e) {
      debugPrint('Fehler beim Laden des Bildes: $e');
    }
  }

  void savePet() async {
    if (!_formKey.currentState!.validate()) return;

    final newPet = Cat(
      name: _nameController.text.trim(),
      species: _selectedType,
      age: 0,
      imageUrl: _imageUrl ?? '',
      appointments: [],
      entries: [],
    );

    await PetManager().addPet(newPet);

    if (!mounted) return;

    // Onboarding beendet → direkt HomeScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false, // alle vorherigen Screens entfernen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Neues Tier anlegen')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _imageUrl != null
                  ? Image.network(_imageUrl!, height: 200)
                  : const SizedBox(height: 200),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: loadRandomImage,
                icon: const Icon(Icons.refresh),
                label: const Text('Zufälliges Bild laden'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name des Tiers',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Bitte Namen eingeben'
                    : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<PetType>(
                value: _selectedType,
                items: PetType.values
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type.name)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedType = value);
                },
                decoration: const InputDecoration(
                  labelText: 'Tier-Typ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: savePet,
                child: const Text('Speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
