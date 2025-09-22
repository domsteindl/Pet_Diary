import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_diary/features/home/widgets/pet_carousel_item.dart';

class PetCarouselWidget extends StatelessWidget {
  const PetCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(3, (index) => PetCarouselItem(index: index)),
      options: CarouselOptions(
        enableInfiniteScroll: true,
        height: 350,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlay: true,
      ),
    );
  }
}
