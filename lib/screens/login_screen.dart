import 'package:flutter/material.dart';
import 'package:instagrammm/screens/signup_screen.dart';
import 'package:instagrammm/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  //allows us to access this screen with id
  static final String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>(); //para validacao do formulario
  String _email, _password;

  _submit() {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      print(_email);
      print(_password);
      AuthService.login(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Instagram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50.0,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //email text field
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (input) => !input.contains('@')                //validation for email - when it comes for signup name use validator: (input) => !input.isEmpty  if you trim it will be like this !input.trim().isEmpty
                          ? 'Please enter valid email'
                          : null,
                      //validator verifica o tipo que deseja verificar, se nao tiver o item desejado, vai devolver a resposta
                      onSaved: (input) => _email = input,
                    ),
                  ),

                  //password text field
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (input) => input.length < 6
                          ? 'Must be at least 6 characthers'
                          : null,
                      onSaved: (input) => _password = input,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //BUTTON LOGIN
                  Container(
                    width: 350.0,
                    child: FlatButton(
                        onPressed: _submit,
                        color: Colors.blue,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        )),
                  ),

                  SizedBox(height: 20.0),

                  //BUTTON SIGN UP
                  Container(
                    width: 350.0,
                    child: FlatButton(
                        onPressed: () => Navigator.pushNamed(context, SignupScreen.id),
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.blue, fontSize: 20.0),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* Neste curso rapido, estarei aprendendo a criar um app clone do
instagram. vou aprender a importar fonts
criar paginas diferentes e importar numa pagina principal
criar formilario de login e signup
validacao de form com global key
*
* */
