import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final String label;
  const QuickActionButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme
            .colorScheme
            .surfaceContainerHighest, // Theme-konformer Hintergrund
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60,
      width: 165,
      child: GestureDetector(
        onTap: () {},
        child: ListTile(
          leading: Icon(
            Icons.book,
            size: 30,
            color: theme.colorScheme.onSurface,
          ),
          title: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface, // Theme-konforme Textfarbe
            ),
          ),
        ),
      ),
    );
  }
}
