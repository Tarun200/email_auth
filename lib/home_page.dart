import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lgm_app/login_page.dart';
import 'package:lgm_app/signup_page.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  navigateToLogin() async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  navigateToSignUp() async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              height: 350,
              child: Image.asset(
                  "assets/home.png",
                fit: BoxFit.contain,
              ),

            ),
            SizedBox(
              height: 20,
            ),
            Text(
                "Welcome to SVCE Mobile App",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25.0,color: Colors.deepPurpleAccent),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                    padding: MaterialStateProperty.all(EdgeInsets.only(left: 30,right: 30)),
                    shape: MaterialStateProperty.all(StadiumBorder()),
                  ),
                    onPressed: navigateToLogin,
                    child: Text(
                        "Login",
                      style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.w400),
                    ),
                ),
                SizedBox(
                  width: 25,
                ),
                ElevatedButton(
                  onPressed: navigateToSignUp,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                    padding: MaterialStateProperty.all(EdgeInsets.only(left: 30,right: 30)),
                    shape: MaterialStateProperty.all(StadiumBorder()),
                  ),
                  child: Text(
                    "Signup",
                    style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),

    );
  }
}

