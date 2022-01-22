import 'package:emergency/model/user.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);
  static const String id = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;

  @override
  void initState() {
    super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final providerUserPref = Provider.of<UserSimplePreferences>(context);
    user = providerUserPref.getUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            wordSpacing: 2,
            color: Colors.grey[300],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 50,
        ),
        child: ListView(
          children: [
            Text(
              'Set Up your user profile name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.45,
                  child: TextFormField(
                    initialValue: user.firstName,
                    cursorColor: Colors.grey[700],
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      enabledBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (firstName) => user = user.copy(
                      firstName: firstName,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.45,
                  child: TextFormField(
                    initialValue: user.lastName,
                    cursorColor: Colors.grey[700],
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      enabledBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (lastName) => user = user.copy(
                      lastName: lastName,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 60,
              ),
              child: InkResponse(
                radius: 30,
                onTap: () {
                  providerUserPref.setUser(user);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
