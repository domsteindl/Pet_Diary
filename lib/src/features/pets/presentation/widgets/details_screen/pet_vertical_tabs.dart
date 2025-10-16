import 'package:flutter/material.dart';

class VerticalTabs extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const VerticalTabs({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(labels.length, (index) {
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () => onTabSelected(index),
          child: Container(
            color: isSelected ? Colors.blue : Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                labels[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
