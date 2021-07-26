import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider_app/widgets/divider_widget.dart';
import 'package:rider_app/widgets/drawer_list.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = 'mainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingofMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        centerTitle: true,
      ),
      drawer: Container(
        width: 255.0,
        color: Colors.white,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/user_icon.png',
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Profile Name',
                            style: TextStyle(
                                fontSize: 15.0, fontFamily: 'Brand Bold'),
                          ),
                          SizedBox(height: 6.0),
                          Text('View Profile'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              DividerLine(),
              SizedBox(height: 12.0),
              DrawerTiles('History', Icon(Icons.history)),
              DrawerTiles('Visit Profile', Icon(Icons.person)),
              DrawerTiles('About', Icon(Icons.info)),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom:bottomPaddingofMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingofMap = 320.0;
              });
              locatePosition();
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0),
                    Text(
                      'Hi, there',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text(
                      'Where to?',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 6.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(width: 10.0),
                            Text('Search Drop off'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.grey,
                          size: 40.0,
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Home'),
                            SizedBox(height: 4.0),
                            Text(
                              'Your residential Home address',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    DividerLine(),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.grey,
                          size: 40.0,
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Work'),
                            SizedBox(height: 4.0),
                            Text(
                              'Your office address',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
