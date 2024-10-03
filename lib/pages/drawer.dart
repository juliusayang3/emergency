import 'package:emergency/pages/profile.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerName extends StatefulWidget {
  const DrawerName({Key? key}) : super(key: key);

  @override
  _DrawerNameState createState() => _DrawerNameState();
}

class _DrawerNameState extends State<DrawerName> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final providerUserPref =
        Provider.of<UserSimplePreferences>(context).getUser();
    return Drawer(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 30,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey[500],
                child: Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.grey[300],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 40,
              width: width / 2.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, Profile.id),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      providerUserPref.firstName!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      providerUserPref.lastName!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
