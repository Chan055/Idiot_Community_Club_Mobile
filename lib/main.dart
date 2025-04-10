// import 'package:flutter/material.dart';
// import 'package:idiot_community_club_app/Routes/IdiotRoutes.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// void main(List<String> args) {
//   runApp(
//     const ProviderScope(child: MyApp())
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: IdiotRoutes.routes,
//     );
//   }
// }
// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idiot_community_club_app/Routes/IdiotRoutes.dart';

void main(List<String> args) {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: IdiotRoutes.routes,
    );
  }
}