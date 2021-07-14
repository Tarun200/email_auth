import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lgm_app/signup_page.dart';
import 'main_page.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();
  String _email="";
  String _password="";

  checkAuth() async {
    _auth.authStateChanges().listen((user){
      if(user!= null)
        {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>MainPage()));
        }
      
    });
    @override
    void initState(){
      super.initState();
      this.checkAuth();
    }

  }

  login()async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      try{
        await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      }
      catch(e){
        showError(e.toString());
        print(e);
      }
    }

  }
  showError(String errormessage){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Error"),
            content: Text(errormessage),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
              ),
            ],
          );

        }
    );
  }
  navigateToSignUp() async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                    "assets/login.png",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(
                                  CupertinoIcons.mail_solid,
                              ),

                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Please enter valid email";
                              }
                              return null;
                            },
                            onSaved: (value) => _email = value!,
                        ),
                        ),
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(
                                CupertinoIcons.lock_fill,
                              ),

                            ),
                            validator: (value){
                              if(value!.length<6){
                                return "Please enter atleast 6 characters";
                              }
                              return null;
                            },
                            onSaved: (value) => _password = value!,
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: login,
                            child: Text(
                                "Login",
                              style: GoogleFonts.poppins(fontSize: 15.0,fontWeight: FontWeight.w400,color: Colors.white),
                            ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                            shape: MaterialStateProperty.all(StadiumBorder()),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: navigateToSignUp,
                child: Text("Create an Account?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
