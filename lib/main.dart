import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QyvraApp());
}

class QyvraApp extends StatelessWidget {
  const QyvraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QYVRA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF7F4),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFC4607A),
          secondary: Color(0xFF7A9E87),
          surface: Color(0xFFFAF7F4),
          onPrimary: Colors.white,
        ),
        textTheme: GoogleFonts.dmSansTextTheme(
          const TextTheme(
            displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Color(0xFF2D2D2D), height: 1.15),
            displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF2D2D2D), height: 1.2),
            headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D)),
            titleLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D)),
            bodyLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xFF2D2D2D), height: 1.6),
            bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6B6B6B), height: 1.6),
            labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFAF7F4),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF2D2D2D)),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC4607A),
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFC4607A),
          unselectedItemColor: Color(0xFF9B9B9B),
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
