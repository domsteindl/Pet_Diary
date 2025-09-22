import 'package:flutter/material.dart';

class PetCarouselItem extends StatelessWidget {
  final int index;
  const PetCarouselItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCD_gKnNlMEqL49zpcHUPrIVTnBNFVWAmAbg&s",
          ),
          SizedBox(height: 16),
          Text("Katze ${index + 1}"),
        ],
      ),
    );
  }
}
