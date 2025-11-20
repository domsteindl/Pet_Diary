import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomPetImage extends StatefulWidget {
  const RandomPetImage({super.key, this.height = 200});

  final double height;

  @override
  State<RandomPetImage> createState() => _RandomPetImageState();
}

class _RandomPetImageState extends State<RandomPetImage> {
  String? imageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRandomImage();
  }

  Future<void> fetchRandomImage() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(
        Uri.parse('https://random.dog/woof.json'),
      );
      final data = json.decode(response.body);
      setState(() {
        imageUrl = data['url'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        imageUrl = null;
      });
    } finally {
        setState(() {
            isLoading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : imageUrl != null
        ? Image.network(imageUrl!, height: widget.height)
        : const Text('Fehler beim Laden des Bildes');
  }
}
