import 'package:flutter/material.dart';
import 'package:lab2flutter/providers/auth_provider.dart';
import 'package:lab2flutter/providers/wifi_provider.dart';
import 'package:lab2flutter/screens/home_screen.dart';
import 'package:lab2flutter/screens/login_screen.dart';
import 'package:lab2flutter/screens/profile_screen.dart';
import 'package:lab2flutter/screens/registration_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = Colors.greenAccent[400]!;
    // ВИПРАВЛЕНО: const Colors.black
    const Color backgroundColor = Colors.black; 
    final Color cardColor = Colors.grey[900]!;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkAuth()),
        ChangeNotifierProvider(create: (_) => WifiProvider()..loadNetworks()),
      ],
      child: MaterialApp(
        title: 'Lab 3 App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: backgroundColor,
          primaryColor: primaryGreen,
          appBarTheme: AppBarTheme(
            backgroundColor: cardColor,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: primaryGreen,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: primaryGreen),
          ),
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
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: Colors.black,
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
          iconTheme: IconThemeData(color: primaryGreen),
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
      ),
    );
  }
}
