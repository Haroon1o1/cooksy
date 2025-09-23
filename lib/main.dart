import 'package:cooksy/Screens/ChefDetails/Screen/Chefdetail.dart';
import 'package:cooksy/Screens/HomeScreen/homeScreen.dart';
import 'package:cooksy/Screens/NearbyScreen/Screen/Nearby.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Hide system nav bar + status bar
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top], // show only the top status bar
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: FoodDeliveryScreen(),
    );
  }
}
