import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron/models/user.dart';
import 'package:ron/screens/authenticate/authenticate.dart';
import 'package:ron/screens/home/home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser>(context);

    // return either Home or authenticate widget
    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
