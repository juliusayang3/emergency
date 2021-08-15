import 'package:emergency/model/phone.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:emergency/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class PhoneNUmberPopUp extends StatefulWidget {
  @override
  _PhoneNUmberPopUpState createState() => _PhoneNUmberPopUpState();
}

class _PhoneNUmberPopUpState extends State<PhoneNUmberPopUp> {
  final _formKey = GlobalKey<FormState>();
  String error = 'Enter correct Phone Number';

  Phone phone;

  @override
  void initState() {
    super.initState();
    phone = UserSimplePreferences.getPhone();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[500],
      content: Stack(
        children: [
          Positioned(
            child: InkResponse(
              radius: 30,
              onTap: () => Navigator.of(context).pop(),
              child: CircleAvatar(
                child: Icon(
                  Icons.close,
                  color: Colors.grey[700],
                ),
                backgroundColor: Colors.grey[500],
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFieldWidget(
                    label: 'Phone Number',
                    text: phone.phoneNumber,
                    onChanged: (phoneNumber) => phone = phone.copy(
                      phoneNumber: phoneNumber,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: InkResponse(
                    radius: 30,
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        UserSimplePreferences.setPhone(phone);
                      }
                      final snackBar = SnackBar(
                        backgroundColor: Colors.grey[500],
                        content: Container(
                          height: 30,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'number saved!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                        shape: StadiumBorder(),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 20,
                        ),
                        duration: Duration(
                          seconds: 2,
                        ),
                        elevation: 0,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 30,
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
        ],
      ),
    );
  }
}
