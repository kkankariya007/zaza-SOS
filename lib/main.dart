import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:flutter_contacts/flutter_contacts.dart' hide Contact;
// import 'package:contacts_service/contacts_service.dart';
// import 'package:contact_picker/contact_picker.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';


// final ContactPicker _contactPicker = ContactPicker();



void main() {

  runApp(const MaterialApp(
    home:SOS(),
  ));
}

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

  Future<void> _selectContacts() async {
    List<Contact> selectedContacts =
    (await _contactPicker.selectContact()as List<Contact>;//multiSelect: true)) as List<Contact>;
    List<String> selectedNumbers = selectedContacts
        .map((contact) =>
    contact.phoneNumber?.number.toString() ?? '') // filter out empty numbers
        .toList();
    setState(() {
      _selectedNumbers = selectedNumbers;
    });
  }

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
          print(link);
           await sendSSMS(link);

          },
          elevation: 10.0,
          padding: const EdgeInsets.all(30.0),
          shape: const CircleBorder(),
    ),
        SizedBox(height: 50,),
        SizedBox(

          height: 30,
          child: MaterialButton(
            onPressed:() async {
              await _selectContacts();
              print("{Hello");
              for (String name in _selectedNumbers) {
              print(name);   }    },
            child: Text("Choose contacts"),
            color: Colors.lightGreenAccent,


          ),
        ),



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
