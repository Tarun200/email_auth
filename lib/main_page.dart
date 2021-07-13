import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoggedin = false;
  User user;
  checkAuth() async{
    _auth.authStateChanges().listen((user) {
      if(user == null)
        {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>HomePage()));
        }
    });
  }
  getUser()async{

  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
