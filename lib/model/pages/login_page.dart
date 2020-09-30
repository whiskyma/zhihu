import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
    @override
    Widget build(BuildContext context){
        final _main = Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30),
            child: Column(
                children: [
                    Text('login')
                ],
            ),
        );
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text('登录',style: TextStyle(color: Colors.white)),
            ),
            body: _main,
        );
    }
}