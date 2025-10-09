import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_diary/src/core/models/pet.dart';
import 'package:pet_diary/src/core/services/pet_manager.dart';
import 'package:pet_diary/src/features/home/presentation/widgets/pet_carousel_item.dart';

class PetCarouselWidget extends StatefulWidget {
  const PetCarouselWidget({super.key});

  @override
  State<PetCarouselWidget> createState() => _PetCarouselWidgetState();
}

class _PetCarouselWidgetState extends State<PetCarouselWidget> {
  int _current = 0;
 List<Pet> pets = PetManager.instance.pets;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: List.generate(
            pets.length,
            (index) => PetCarouselItem(pet: pets[index]),
          ),
          options: CarouselOptions(
            onPageChanged: (index, reason) => setState(() {
              _current = index;
            }),
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            enableInfiniteScroll: true,
            height: 450,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlay: true,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pets.asMap().entries.map((entry) {
            return Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == entry.key
                    ? Colors.blueAccent
                    : Colors.grey[400],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
