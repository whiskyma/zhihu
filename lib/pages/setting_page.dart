import 'package:flutter/material.dart';
import 'package:flutter_zhihu/utils/http_util.dart';



class SettingPage extends StatefulWidget{
    @override
    _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{
    @override
    void initState(){
        super.initState();
        _sendRequest();
    }
    void _sendRequest(){
        print(1);
        // 发起请求
        HttpUtil.get('/home/getHomeBanner', data: {'gameBannerType':0},
            success: (data){
                print('成功了...');
                print(data[0]['gameBannerUrl']);
            },
            error: (errorMsg){
                print('错误了...');
                print(errorMsg);
            }
        );
    }
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