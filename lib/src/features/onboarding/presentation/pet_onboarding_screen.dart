import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pet_diary/src/features/home/presentation/screens/home_screen.dart';
import 'package:pet_diary/src/features/pets/presentation/screens/pet_add_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  bool _loading = true;

  // Zufallsbilder für die ersten beiden Seiten
  late final List<String> images;

  @override
  void initState() {
    super.initState();
    _initImages();
  }

  Future<void> _initImages() async {
    images = [];
    // lade Bilder für die ersten zwei Seiten
    for (int i = 0; i < 2; i++) {
      images.add(await fetchRandomDogImage());
    }
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<String> fetchRandomDogImage() async {
    final response = await http.get(
      Uri.parse('https://random.dog/woof.json?ref=public_apis'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['url'] as String;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      // Ladeindikator, bis alle Bilder da sind
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                color: Colors.teal.shade50,
                imageUrl: images[0],
                title: 'Willkommen bei Pet Diary 🐾',
                subtitle:
                    'Behalte den Überblick über deine Tiere mit einer App.',
              ),
              buildPage(
                color: Colors.teal.shade100,
                imageUrl: images[1],
                title: 'Pflege leicht gemacht',
                subtitle:
                    'Füge Erinnerungen, Fotos und Notizen zu jedem Tier hinzu.',
              ),
              buildPage(
                color: Colors.teal.shade200,
                imageUrl: images[0],
                title: "Verfolge die Entwicklung",
                subtitle:
                    "Verfolge ganz einfach die Entwicklung deiner Tiere. z. B. Essverhalten, Gewichtsveränderungen usw.",
              ),
              buildLastPage(context),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text('Überspringen'),
              onPressed: () => goToHome(context),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: const WormEffect(
                  activeDotColor: Colors.teal,
                  dotColor: Colors.grey,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
            TextButton(
              child: Text(isLastPage ? 'Fertig' : 'Weiter'),
              onPressed: () {
                if (isLastPage) {
                  goToHome(context);
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required Color color,
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, height: 200),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Text(subtitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget buildLastPage(BuildContext context) {
    return Container(
      color: Colors.teal.shade200,
      child: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.pets),
          label: const Text('Mein erstes Tier anlegen'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () => goToPetAdd(context),
        ),
      ),
    );
  }

  Future<void> goToHome(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  Future<void> goToPetAdd(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PetAddScreen()),
    );
  }
}
