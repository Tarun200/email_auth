

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lgm_app/main_page.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _password = "";
  checkAuth() async {
    _auth.authStateChanges().listen((user) async {
      if(user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
      }
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuth();
  }
  signUp() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      try{
        UserCredential user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        if(user!= null){
          await _auth.currentUser!.updateProfile(displayName: _name);
        }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
                SizedBox(
                  height: 25,
                ),
              Container(
                child: Image.asset(
                    "assets/welcome.png",
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child:  Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Username",
                              prefixIcon: Icon(
                                CupertinoIcons.person,
                              ),
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Please enter valid username";
                              }
                              return null;
                            },
                            onSaved: (value)=> _name = value!,
                          ),
                        ),
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
                                return "Please enter valid mail";
                              }
                              return null;
                            },
                            onSaved: (value)=> _email = value!,
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
                             if(value!.length < 6)
                               {
                                 return "Please enter atleast 6 characters";
                               }
                             return null;
                            },
                            onSaved: (value)=> _password = value!,
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                            onPressed: signUp,
                            child: Text(
                                "SignUp",
                              style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),
                            ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(StadiumBorder()),
                            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                          ),
                        ),
                      ],
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
