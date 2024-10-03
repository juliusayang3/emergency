import 'package:emergency/utils/helper_functions.dart';
import 'package:emergency/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';

class AddPhoneNumber extends StatefulWidget {
  static const String id = 'addPhoneNumber';

  @override
  _AddPhoneNumberState createState() => _AddPhoneNumberState();
}

class _AddPhoneNumberState extends State<AddPhoneNumber> {
  List contacts = [];
  bool loading = false;

  getAllContacts() async {
    setState(() {
      loading = true;
    });
    try {
      List<Contact> _contacts = await ContactsService.getContacts();
      setState(() {
        contacts = _contacts;
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getAllContacts);
  }

  @override
  Widget build(BuildContext context) {
    final providerUserPref = Provider.of<UserSimplePreferences>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Select Contact',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      Contact contact = contacts.elementAt(index);
                      return Column(
                        children: [
                          ListTile(
                            leading: (contact.avatar != null &&
                                    contact.avatar!.isNotEmpty)
                                ? CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(contact.avatar!),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Text(contact.initials()),
                                  ),
                            title: Text(contact.displayName ?? 'No name'),
                            subtitle: Text(HelperFunctions.getValidPhoneNumber(
                                    contact.phones!) ??
                                ''),
                            onTap: () {
                              String? number =
                                  HelperFunctions.getEmergencyPhoneNumber(
                                HelperFunctions.getValidPhoneNumber(
                                    contact.phones!),
                              );
                              providerUserPref.setPhoneNumber(number ?? '');
                              final snackBar = SnackBar(
                                content: Text('Phone Number added'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context).pop();
                            },
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
