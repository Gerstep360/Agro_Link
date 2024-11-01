// lib/themes/themes.dart

import 'package:flutter/material.dart';

class Themes {
  // Colores principales
  static const Color primaryColor = Color(0xFF4CAF50); // Verde medio claro
  static const Color primaryLightColor = Color(0xFF81C784); // Verde claro
  static const Color backgroundColor = Color(0xFF303030); // Gris oscuro
  static const Color textColor = Colors.white;
  static const Color textSecondaryColor = Color(0xFFB2FF59); // Verde más claro para texto secundario
  static const Color inputFillColor = Color(0xFF424242); // Gris oscuro para campos de texto
  static const Color secondaryColor = Color(0xFF009688); // Verde azulado para botones secundarios
  static const Color hintTextColor = Color(0xFFB2FF59); // Verde más claro

  // Estilos de texto
  static const TextStyle titleTextStyle = TextStyle(
    color: textColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    color: textSecondaryColor,
    fontSize: 16,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: textColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // Estilo de AppBar
  static AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: titleTextStyle.copyWith(fontSize: 20),
        iconTheme: const IconThemeData(color: textColor),
      );

  // Estilo de TextField
  static InputDecoration inputDecoration({required String hintText}) {
    return InputDecoration(
      labelText: hintText,
      labelStyle: const TextStyle(color: textSecondaryColor),
      filled: true,
      fillColor: inputFillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryLightColor, width: 1.5),
      ),
    );
  }

  // Estilo de Botón Elevado
  static ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: primaryLightColor,
      foregroundColor: textColor,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: buttonTextStyle,
    );
  }

  // Estilo de botones de texto (para botones secundarios)
  static ButtonStyle textButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: primaryColor,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // Tema general
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: appBarTheme,
      textTheme: const TextTheme(
        titleLarge: titleTextStyle,
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        titleMedium: subtitleTextStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle()),
      textButtonTheme: TextButtonThemeData(style: textButtonStyle()),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: textSecondaryColor),
        hintStyle: const TextStyle(color: hintTextColor),
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: inputFillColor,
        onPrimary: textColor,
        onSecondary: textColor,
      ),
    );
  }
}
