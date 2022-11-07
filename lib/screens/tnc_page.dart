import 'package:flutter/material.dart';

enum Location { gate, canteen, micmac, mechc, oat, audi, acaddept }

class TNCScreen extends StatefulWidget {
  static String routeName = '/tnc-screen';
  TNCScreen({Key? key}) : super(key: key);

  @override
  _TNCScreenState createState() => _TNCScreenState();
}

class _TNCScreenState extends State<TNCScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5,
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              ListTile(
                title: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Long subtitle text"),
              ),
              ListTile(
                title: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Long subtitle text"),
              ),
              ListTile(
                title: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Long subtitle text"),
              ),
              ListTile(
                title: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Long subtitle text"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
