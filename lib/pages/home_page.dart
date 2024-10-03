import 'package:emergency/pages/confirm_number.dart';
import 'package:emergency/pages/drawer.dart';
import 'package:emergency/pages/profile.dart';
import 'package:emergency/utils/location.dart';
import 'package:emergency/utils/message.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String error = 'Enter correct Phone Number';

  @override
  void initState() {
    super.initState();
    Provider.of<GetLocation>(context, listen: false).determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final providerUserPref = Provider.of<UserSimplePreferences>(context);
    final providerLocation = Provider.of<GetLocation>(context);
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Emergency',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            InkResponse(
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(
                  right: 15,
                ),
                height: double.infinity,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          centerTitle: true,
        ),
        drawer: DrawerName(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Container(
                  height: height * 0.06,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 30,
                        ),
                        providerLocation.currentPosition != null
                            ? Expanded(
                                child: Text(
                                  'LAT: ' +
                                      providerLocation
                                          .currentPositionLatitude! +
                                      '  LONG: ' +
                                      providerLocation
                                          .currentPositionLongitude! +
                                      '  ACC: ' +
                                      providerLocation.currentPositionAccuracy!,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : Text(
                                'Loading co-ordinates ....',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Container(
                  height: height * 0.06,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 30,
                        ),
                        providerLocation.currentAddress != null
                            ? Expanded(
                                child: Text(
                                  providerLocation.currentAddress!,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              )
                            : Text(
                                'Loading current address ....',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[700],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                ),
                child: InkResponse(
                  onTap: () async {
                    // final PermissionStatus? permissionStatus =
                    //     await ContactUtil.getPermission();
                    // if (permissionStatus == PermissionStatus.granted) {
                    Navigator.pushNamed(context, ConfirmNumber.id);
                    // } else {
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) => CustomAlertDialog(
                    //       title: 'Permission Error',
                    //       content: 'Please enable contacts access',
                    //       onPressed: () {},
                    //     ),
                    //   );
                    // }
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            providerUserPref.getPhoneNumber != null
                                ? Icons.person
                                : Icons.person_add,
                            size: 30,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            providerUserPref.getPhoneNumber ??
                                'Input Emergency Number',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    MessageUtil.sendMessage(
                      'This is an EMERGENCY ALERT!!\nCurrent Location: https://www.google.com/maps/search/?api=1&query=' +
                          providerLocation.currentPositionLatitude! +
                          ',' +
                          providerLocation.currentPositionLongitude!,
                      providerUserPref.getPhoneNumber!,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: PhysicalModel(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      elevation: 10,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                          border: Border.all(
                            width: 10,
                            color: Colors.grey[600]!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
