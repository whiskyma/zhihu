// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_zhihu/utils/http.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_zhihu/widget/open_img.dart';
import 'package:flutter_zhihu/theme/theme_style.dart';


class NewsDetail extends StatefulWidget{
    final int id;
    const NewsDetail({Key key, this.id}):super(key:key);
    @override
    _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail>{
    String _html = '';
    // 获取内容主体
    void getHtml() async {
        try{
            var res = await Http().get('news/${widget.id}');
            print(res['body']);
            setState((){
                _html = res['body'];
            });
            
        } catch(e){

        }
    }

    // 用浏览器打开
    void _website(String url) async {
        print(url);
        if(await canLaunch(url)){  //canLaunch(url)---检查当前环境是否有可以处理URL的应用
            await launch(url);
        }else{
            throw 'Could not launch $url';
        }
    }

    @override
    void initState(){
        super.initState();
        getHtml();
    }
    @override
    Widget build(BuildContext context){
        final _main = Container(
            width: MediaQuery.of(context).size.width,
            color: ThemeStyle.of(context).drawerBackground,
            child: ListView(
                children: [
                    _html.length>0?Html(
                        data: _html,
                        padding: EdgeInsets.all(15),
                        defaultTextStyle: TextStyle(
                            fontSize: 17,
                            fontFamily: 'serif'
                        ),
                        // linkStyle: TextStyle( //处理a标签样式
                        //     color: Colors.redAccent,
                        // ),
                        onImageTap: (src){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => OpenImg(url: src.toString())
                                )
                            );
                        },
                        onLinkTap: (url){
                            _website(url);
                        },
                        // useRichText: false,
                    ):Container(
                        height: 100,
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                                strokeWidth: 2
                            ),
                        ),
                    )
                ],
            ),
        );
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text('详情', style: TextStyle(color: Colors.white)),
            ),
            body: _main,
        );
    }
}