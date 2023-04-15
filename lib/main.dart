import 'dart:async';
import 'package:contact_picker/contact_picker.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

String? _ch;
void main() {

  runApp(const MaterialApp(
    home:SOS(),
  ));
}
//
// List<Contact> pickedContacts = [];
//
// Future<Contact> pickContact() async {
//
//   var status = await Permission.contacts.status;
//   if (status.isDenied) {
//     await Permission.contacts.request();
//   }
//
//   // Get all contacts on the device
//   Iterable<Contact> contacts =
//   await ContactsService.getContacts(withThumbnails: false);
//
//   // Display the contact picker dialog
//   Contact contact = (await ContactsService.getContacts()) as Contact;
//
//   return contact;
// }
//



class SOS extends StatefulWidget {
  const SOS({Key? key}) : super(key: key);

  @override
  State<SOS> createState() => _SOSState();
}

Future<String> _getMapsLink(double latitude, double longitude) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
  Placemark placemark = placemarks[0];
  String mapsLink = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  return mapsLink;
}

Future<void> sendSSMS(String link) async {
  String message = "Hello, this is an automated message. "+link;
  List<String> recipients = ["+919347821062", "+919755344895","+919974275334","+918076891336"];

  String result = await sendSMS(message: message, recipients: recipients)
      .catchError((onError) {
    print(onError);
  });

  if (result != null) {
    print("SMS sent successfully");
  }
  else
    print("Error sending the SMS");
}


Future<String> _getCurrentLocation() async {
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (isLocationServiceEnabled) {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String googleMapsLink =
        'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
    return googleMapsLink;
  } else {
    throw 'Location service is not enabled';
  }
}



class _SOSState extends State<SOS> {

  final ContactPicker _contactPicker = new ContactPicker();
  Contact? _contact;
  PhoneNumber? _ph;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      title: Text('Emergency'),
        elevation: 0,
      ),


      body:
      Center(
      child:Container(decoration: const BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.purpleAccent,
        Colors.redAccent,
        ],
      ),
      ),

        child:Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

        SizedBox(height: 250.0),

        RawMaterialButton(
        constraints: BoxConstraints.tight(Size(300,300)),
        fillColor: Colors.black.withOpacity(0.68),
        child: Center(
        child: Text('Send',
        style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
                          ),
                    ),
        ),

          onPressed: () async {
          String link= await _getCurrentLocation();
          await sendSSMS(link);
          },
          elevation: 10.0,
          padding: const EdgeInsets.all(30.0),
          shape: const CircleBorder(),
        ),

          SizedBox(height: 30,),
          MaterialButton(
              onPressed: () async {
                Contact contact= await _contactPicker.selectContact();
                setState(() {
                  _contact=contact;
                  _ch=contact.phoneNumber.number;
                });
                print(_ch);
          },
            color: Colors.greenAccent,
          ),

          new Text(
            _contact == null ? 'No contact selected.' : _contact.toString(),
          ),

          new Text(_ch.toString().replaceAll(' ','*')),


        ],
                    ),
                  ),
            ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
    );
  }
}
