import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget{
    @override
    _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{
    @override
    Widget build(BuildContext context){
        final _main = Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30),
            child: Column(
                children: [
                    Text('setting')
                ],
            ),
        );
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text('设置',style: TextStyle(color: Colors.white)),
            ),
            body: _main,
        );
    }
}