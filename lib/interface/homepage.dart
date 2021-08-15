import 'package:emergency/interface/drawer.dart';
import 'package:emergency/interface/phoneNumberPopUp.dart';
import 'package:emergency/interface/profile.dart';
import 'package:emergency/model/phone.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Telephony telephony = Telephony.instance;

  String error = 'Enter correct Phone Number';

  String currentAddress;
  Position currentPosition;

  final phone = UserSimplePreferences.getPhone();

  final user = UserSimplePreferences.getUser();

  @override
  void initState() {
    super.initState();

    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    
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
                setState(() {});
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
                        currentPosition != null
                            ? Text(
                                'LAT: ' +
                                    currentPosition.latitude
                                        .toStringAsPrecision(5) +
                                    '  LONG: ' +
                                    currentPosition.longitude
                                        .toStringAsPrecision(5) +
                                    '  ACC: ' +
                                    currentPosition.accuracy
                                        .toStringAsPrecision(5),
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
                        currentAddress != null
                            ? Text(
                                currentAddress,
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
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PhoneNUmberPopUp();
                      },
                    );
                    setState(() {});
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
                            phone.phoneNumber != null
                                ? Icons.person
                                : Icons.person_add,
                            size: 30,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          phone.phoneNumber != null
                              ? Text(
                                  phone.phoneNumber,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                )
                              : Text(
                                  'Input Emergency Phone number',
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
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _sendMessage(
                      'This is an EMERGENCY ALERT!!\nCurrent Location: https://www.google.com/maps/search/?api=1&query=' +
                          currentPosition.latitude.toString() +
                          ',' +
                          currentPosition.longitude.toString(),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: PhysicalModel(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      elevation: 50,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
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

  _sendMessage(String message) async {
    var status = await Permission.sms.status;
    // check permission status
    if (status.isDenied) {
      print('permission denied');
    }
    if (status.isGranted) {
      print('permission granted');
    }

    print(phone.phoneNumber);

    // check if a device is capable of sending SMS
    bool canSendSms = await telephony.isSmsCapable;
    print(canSendSms);

    // get sim state
    SimState simState = await telephony.simState;
    print(simState);

    telephony.sendSms(
      to: phone.phoneNumber,
      message: message,
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please keep your location on');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permission is denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission is denied forever');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemark[0];
      setState(() {
        currentPosition = position;
        currentAddress =
            " ${place.street}, ${place.postalCode}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
