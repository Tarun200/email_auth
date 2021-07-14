import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoggedin = false;
  User? user;
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
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;
    if(firebaseUser != null){
      setState(() {
        this.user = firebaseUser;
        this.isLoggedin = true;
      });
    }
  }
  signOut(){
    _auth.signOut();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuth();
    this.getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: !isLoggedin
        ? CircularProgressIndicator()
            :Column(
          children: [
            Container(
              child: Image.asset(
                "assets/welcome.png",
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Text(
                  "Hello ${user!.displayName} you are logged in as ${user!.email}",
                style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),
              ),
            ),
            ElevatedButton(
                onPressed: signOut,
                child: Text(
                    "Signout",
                  style: GoogleFonts.poppins(fontSize: 15,color: Colors.white),

                ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                shape: MaterialStateProperty.all(StadiumBorder()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
