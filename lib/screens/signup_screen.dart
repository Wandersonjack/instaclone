import 'package:flutter/material.dart';
import 'package:instagrammm/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  static final String id = "signup_screen";


  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password;

  _submit(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      AuthService.signUpUser(context, _name, _email, _password);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Instagram",
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Billabong',
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          validator: (input) => input.trim().isEmpty ? 'Please enter your name' : null,
                          onSaved:(input) => _name = input ,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (input) =>  !input.contains('@') ? 'Please enter your email address' : null,
                          onSaved:(input) => _email = input ,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: (input) => input.isEmpty && input.length < 6 ? 'Please enter a password' : null,
                          onSaved:(input) => _password = input ,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: 350.0,
                        child: FlatButton(
                          onPressed: _submit,
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                          color: Colors.blue,
                          child: Text('Sign up', style:TextStyle(color: Colors.white, fontSize: 20.0),) ,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: 350.0,
                        child: FlatButton(
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                          child: Text('Already have account? Login', style:TextStyle(color: Colors.blue, fontSize: 16.0),) ,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
