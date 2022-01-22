import 'package:emergency/interface/add_phonenumber_contact.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmNumber extends StatefulWidget {
  static String id = 'confirm_number';
  ConfirmNumber({Key key}) : super(key: key);

  @override
  State<ConfirmNumber> createState() => _ConfirmNumberState();
}

class _ConfirmNumberState extends State<ConfirmNumber> {
  final _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerUserPref = Provider.of<UserSimplePreferences>(context);
    _controller.text = providerUserPref.offlineNumber;
    _controller.text = providerUserPref.getPhoneNumber;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add emergency contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AddPhoneNumber.id);
                  },
                  icon: Icon(
                    Icons.contacts,
                    color: Colors.black54,
                  ),
                ),
                suffixIconColor: Colors.black54,
                hintText: 'Enter phone number',
                hintStyle: TextStyle(
                  color: Colors.black54,
                ),
                hoverColor: Colors.red,
                focusColor: Colors.black,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54,
                  ),
                ),
              ),
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(
              height: 40,
            ),
            PhysicalModel(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(5),
              elevation: 5,
              child: InkWell(
                onTap: () {
                  providerUserPref.setPhoneNumber(_controller.text);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
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
