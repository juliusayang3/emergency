import 'package:emergency/interface/homepage.dart';
import 'package:emergency/interface/profile.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  runApp(Root());
}

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey[700],
        scaffoldBackgroundColor: Colors.grey[500],
        buttonColor: Colors.grey[700],
      ),
      routes: {
        '/profile': (context) => Profile(),
      },
    );
  }
}
