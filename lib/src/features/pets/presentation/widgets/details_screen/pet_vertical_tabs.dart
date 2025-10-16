import 'package:flutter/material.dart';

class VerticalTabs extends StatefulWidget {
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
  State<VerticalTabs> createState() => _VerticalTabsState();
}

class _VerticalTabsState extends State<VerticalTabs> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(widget.labels.length, (index) {
        final isSelected = widget.selectedIndex == index;

        return GestureDetector(
          onTap: () => widget.onTabSelected(index),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(vertical: 6),

            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
              border: Border.all(
                color: isSelected ? colorScheme.primary : Colors.transparent,
              ),
            ),

            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                widget.labels[index],
                maxLines: 1,
                style: textTheme.titleSmall?.copyWith(
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,
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
