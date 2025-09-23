import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_diary/core/enums/pet_type.dart';
import 'package:pet_diary/core/models/pet.dart';
import 'package:pet_diary/features/home/widgets/pet_carousel_item.dart';

class PetCarouselWidget extends StatefulWidget {
  const PetCarouselWidget({super.key});

  @override
  State<PetCarouselWidget> createState() => _PetCarouselWidgetState();
}

class _PetCarouselWidgetState extends State<PetCarouselWidget> {
  int _current = 0;
  static final List<Pet> animals = [
    Pet(
      name: "Luna",
      species: PetType.cat,
      age: 24,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
    ),
    Pet(
      name: "Mark",
      species: PetType.cat,
      age: 22,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
    ),
    Pet(
      name: "Sebastian",
      species: PetType.dog,
      age: 18,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Cat_August_2010-4.jpg/1200px-Cat_August_2010-4.jpg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: List.generate(
            3,
            (index) => PetCarouselItem(pet: animals[index]),
          ),
          options: CarouselOptions(
            onPageChanged: (index, reason) => setState(() {
              _current = index;
            }),
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            enableInfiniteScroll: true,
            height: 350,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlay: true,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: animals.asMap().entries.map((entry) {
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
