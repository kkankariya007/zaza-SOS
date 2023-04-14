import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fast_contacts/fast_contacts.dart';


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
              final List<Contact> contacts = await FastContacts.pickContacts(
                context,
                multiple: true,
              );
              print(contacts);
            },
            child: Text('Select multiple contacts'),
          ),

        SizedBox(height: 150,),

          SizedBox(
          height: 30,
          child: MaterialButton(

            onPressed:() async {
             // await Navigator.push(
             //   context,
             //   MaterialPageRoute(
             //     builder: (BuildContext context) => HomePage()
                   // selectedContacts: _selectedContacts,
             //
             //   ),
             // );
             //  // await HomePage();
              // print(_selectedContacts.toString());

                // Do something with the selected contacts
            },
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
