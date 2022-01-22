import 'package:emergency/interface/add_phonenumber_contact.dart';
import 'package:emergency/interface/confirm_number.dart';
import 'package:emergency/interface/homepage.dart';
import 'package:emergency/interface/profile.dart';
import 'package:emergency/utils/location.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  runApp(Root());
}

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserSimplePreferences>.value(
          value: UserSimplePreferences(),
        ),
        ChangeNotifierProvider<GetLocation>.value(
          value: GetLocation(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.grey[700],
          scaffoldBackgroundColor: Colors.grey[500],
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.grey[600],
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.grey[700],
          ),
        ),
        routes: {
          Profile.id: (context) => Profile(),
          AddPhoneNumber.id: (context) => AddPhoneNumber(),
          ConfirmNumber.id: (context) => ConfirmNumber(),
        },
      ),
    );
  }
}
