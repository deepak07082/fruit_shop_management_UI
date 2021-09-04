import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fruit_shop/Screens/fruitlistview.dart';

import 'Screens/dashboard.dart';
import 'Screens/loginpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit shop',
      initialRoute: '/',
      routes: {
        '/': (context) => IntroPage(),
        '/dashboard': (context) => Dashboard(),
        '/fruitlist': (context) => Fruitlistview(),
        '/login': (context) => LoginScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: IntroPage(),
    );
  }
}

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                // color: Colors.red,
                child: Image.asset(
                  "lib/assets/pic_orange.png",
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Order your Favourites",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Fruits",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Fruit is one of the ingredients to keep our body well. which helps our body to prevent disease.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  textBaseline: TextBaseline.alphabetic,
                  // fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFf15c00),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Get Start",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
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
}
