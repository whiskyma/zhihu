import 'package:flutter/material.dart';
import '../model/author.dart';


class NoticePage extends StatefulWidget{
    @override
    _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>{
    void _getData() async {
        var obj = {"name":"whisky", "title":'阿发生的发生阿斯蒂芬暗示法按时', "id":2020};
        var c = Author.fromJson(obj);
        print("作者的名字是："+c.name);
        print("作者的名字是："+c.title);
        print('${c.id}');
        print('${c.id.runtimeType}');
        print(c);
    }

    @override
    void initState(){
        super.initState();
        _getData();
    }

    @override
    Widget build(BuildContext context){
        final _main = Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30),
            child: Column(
                children: [
                    Text('notice')
                ],
            ),
        );
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text('我的消息',style: TextStyle(color: Colors.white)),
            ),
            body: _main,
        );
    }
}