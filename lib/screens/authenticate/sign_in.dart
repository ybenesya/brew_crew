import 'package:flutter/material.dart';
import 'package:ron/services/auth.dart';
import 'package:ron/shared/constants.dart';
import 'package:ron/shared/loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: (){
                widget.toggleView();
              },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
              label: Text(
            'Register',
            style: TextStyle(
                color: Colors.black),),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) {
                  if (val != null && val.isEmpty){
                    return 'Enter an email';
                  }else{
                    return null;
                  }
                },
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) {
                  if (val != null && val.length < 6){
                    return 'Enter a password 6+ chars long';
                  }else{
                    return null;
                  }
                },
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                ),
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white,),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error = 'could not sign in with those credentials';
                        loading = false;
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize:14.0 ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
