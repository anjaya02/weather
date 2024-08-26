import 'package:easyweather/pages/home_page.dart';
import 'package:easyweather/provider/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeProvider.getThemeData,
          home: const HomePage(),
        );
      },
    );
  }
}





  // theme: ThemeData(
  //       fontFamily: 'Poppins', // Set the default font for the app
  //       textTheme: const TextTheme(
  //         headlineLarge:
  //             TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
  //         headlineMedium:
  //             TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
  //         bodyLarge: TextStyle(fontFamily: 'Poppins'),
  //         bodyMedium: TextStyle(fontFamily: 'Poppins'),
  //       ),
  //     ),