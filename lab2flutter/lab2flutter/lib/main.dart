// lib/main.dart
import 'package:flutter/material.dart';
import 'package:lab2flutter/screens/home_screen.dart';
import 'package:lab2flutter/screens/login_screen.dart';
import 'package:lab2flutter/screens/profile_screen.dart';
import 'package:lab2flutter/screens/registration_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = Colors.greenAccent[400]!;
    const Color backgroundColor = Colors.black;
    final Color cardColor = Colors.grey[900]!;

    return MaterialApp(
      title: 'Lab 2 App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: primaryGreen,
        
        // Тема для AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: cardColor, // Трохи світліше за фон
          elevation: 0,
          titleTextStyle: TextStyle(
            color: primaryGreen,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: primaryGreen), // Колір іконок AppBar
        ),

        // Тема для полів вводу
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey[400]),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[800]!),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryGreen, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Тема для кнопок
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            foregroundColor: Colors.black, // Колір тексту на кнопці
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        cardTheme: CardThemeData(
          color: cardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Колір звичайних іконок
        iconTheme: IconThemeData(
          color: primaryGreen,
        ),

        // Колір тексту
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegistrationScreen.routeName: (context) => const RegistrationScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
      },
    );
  }
}
