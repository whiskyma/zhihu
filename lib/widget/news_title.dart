import 'package:flutter/material.dart';

class NewsTitleWidget extends StatefulWidget{
    final String title;
    const NewsTitleWidget({Key key,this.title}):super(key: key);
    @override
    _NewsTitleWidgetState createState() => _NewsTitleWidgetState();
}

class _NewsTitleWidgetState extends State<NewsTitleWidget>{
    Widget build(BuildContext context){
        return Padding(
            padding: EdgeInsets.all(10),
            child: Text(widget.title, style: TextStyle(fontSize: 15,color: Color(0xff666666))),
        );
    }
}
