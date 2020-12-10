import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Request',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String identity = '';
  String public = '';
  String pppUser = '';
  String pppPass = '';
  String version = '';
  String par = '';

  getGreet() async {
    //async function to perform http get

    final response = await http.get(
        'http://127.0.0.1:5000/'); //getting the response from our backend server script

    final decoded = json.decode(response.body)
        as Map<String, dynamic>; //converting it from json to key value pair

    setState(() {
      // in here first variable is Flutter local var and second var is coming from python script

      identity = decoded[
          'identity']; //changing the state of our widget on data update //FOR MY NOTE>>>>THIS MUST BE SAME WITH THE VARIABLE IN THE PYTHON FILE

      public = decoded['public'];
      pppUser = decoded['ppp_user'];
      pppPass = decoded['ppp_pass'];
      version = decoded['version'];
      par = decoded['par'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                identity, //SYSTEM_IDENTITY that will be displayed on the screen
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20.0,
            ),
            Text(par, //PUBLIC_ADDRESS that will be displayed on the screen
                style: TextStyle(fontSize: 24)),
            SizedBox(
              height: 20.0,
            ),
            Text(public, //PUBLIC_ADDRESS that will be displayed on the screen
                style: TextStyle(fontSize: 24)),
            SizedBox(
              height: 20.0,
            ),
            Text(version, //Text that will be displayed on the screen
                style: TextStyle(fontSize: 24)),
            SizedBox(
              height: 20.0,
            ),
            Text(pppUser, //Text that will be displayed on the screen
                style: TextStyle(fontSize: 24)),
            SizedBox(
              height: 20.0,
            ),
            Text(pppPass, //Text that will be displayed on the screen
                style: TextStyle(fontSize: 24)),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                //container that contains the button
                width: 150,
                height: 60,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    getGreet();
                  },
                  child: Text(
                    'Press',
                    style: TextStyle(
                      fontSize: 24,
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
