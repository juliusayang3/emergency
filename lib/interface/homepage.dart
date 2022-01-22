import 'package:emergency/interface/confirm_number.dart';
import 'package:emergency/interface/drawer.dart';
import 'package:emergency/interface/add_phonenumber_contact.dart';
import 'package:emergency/interface/profile.dart';
import 'package:emergency/model/phone.dart';
import 'package:emergency/utils/contacts.dart';
import 'package:emergency/utils/location.dart';
import 'package:emergency/utils/message.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:emergency/widgets/custom_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  //final Telephony telephony = Telephony.instance;

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
    print(Provider.of<GetLocation>(context).currentPosition.toString());
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Emergency',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              wordSpacing: 2,
              color: Colors.grey[300],
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
                  color: Colors.grey[300],
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
                      color: Colors.grey[300],
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
                            ? Text(
                                'LAT: ' +
                                    providerLocation.currentPositionLatitude +
                                    '  LONG: ' +
                                    providerLocation.currentPositionLongitude +
                                    '  ACC: ' +
                                    providerLocation.currentPositionAccuracy,
                                style: TextStyle(
                                  fontSize: 16,
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
                      color: Colors.grey[300],
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
                            ? Text(
                                providerLocation.currentAddress,
                                style: TextStyle(
                                  fontSize: 17,
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
                    final PermissionStatus permissionStatus =
                        await ContactUtil.getPermission();
                    if (permissionStatus == PermissionStatus.granted) {
                      Navigator.pushNamed(context, ConfirmNumber.id);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomAlertDialog(
                          title: 'Permission Error',
                          content: 'Please enable contacts access',
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey[300],
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
                  onTap: () {
                    MessageUtil.sendMessage(
                      'This is an EMERGENCY ALERT!!\nCurrent Location: https://www.google.com/maps/search/?api=1&query=' +
                          providerLocation.currentPositionLatitude +
                          ',' +
                          providerLocation.currentPositionLongitude,
                      providerUserPref.getPhoneNumber,
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
                            color: Colors.grey[600],
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
