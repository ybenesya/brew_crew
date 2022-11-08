import 'package:flutter/material.dart';
import 'package:ron/screens/home/settings_form.dart';
import 'package:ron/services/auth.dart';
import 'package:ron/services/datadase.dart';
import 'package:provider/provider.dart';
import 'package:ron/screens/home/brew_list.dart';
import 'package:ron/models/brew.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider< List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400] ,
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: Text(
                'logout',
              style: TextStyle(
                  color: Colors.black),
              ),
              onPressed: () async{
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: Text(
                'settings',
                style: TextStyle(
                    color: Colors.black),
              ),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
