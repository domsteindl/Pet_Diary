// util.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFont, String displayFont) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;

  // Google Fonts holen (haben inherit=false)
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFont, baseTextTheme).apply(
    bodyColor: baseTextTheme.bodyMedium?.color,
    displayColor: baseTextTheme.bodyMedium?.color,
  );

  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFont, baseTextTheme).apply(
    bodyColor: baseTextTheme.bodyMedium?.color,
    displayColor: baseTextTheme.bodyMedium?.color,
  );

  // Body Fonts in Display Fonts übernehmen
  TextTheme combined = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );

  // Alle TextStyles auf inherit=true setzen (fix für AnimatedTheme)
  return fixInherit(combined);
}

// Helper, damit AnimatedTheme nicht crasht
TextTheme fixInherit(TextTheme theme) {
  return theme.copyWith(
    displayLarge: theme.displayLarge?.copyWith(inherit: true),
    displayMedium: theme.displayMedium?.copyWith(inherit: true),
    displaySmall: theme.displaySmall?.copyWith(inherit: true),
    headlineLarge: theme.headlineLarge?.copyWith(inherit: true),
    headlineMedium: theme.headlineMedium?.copyWith(inherit: true),
    headlineSmall: theme.headlineSmall?.copyWith(inherit: true),
    titleLarge: theme.titleLarge?.copyWith(inherit: true),
    titleMedium: theme.titleMedium?.copyWith(inherit: true),
    titleSmall: theme.titleSmall?.copyWith(inherit: true),
    bodyLarge: theme.bodyLarge?.copyWith(inherit: true),
    bodyMedium: theme.bodyMedium?.copyWith(inherit: true),
    bodySmall: theme.bodySmall?.copyWith(inherit: true),
    labelLarge: theme.labelLarge?.copyWith(inherit: true),
    labelMedium: theme.labelMedium?.copyWith(inherit: true),
    labelSmall: theme.labelSmall?.copyWith(inherit: true),
  );
}
