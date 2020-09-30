import 'package:flutter/material.dart';
import 'dart:io'; //判断ios还是android插件
import 'package:flutter_drag_scale/flutter_drag_scale.dart'; //图片点击放大插件
import 'package:image_gallery_saver/image_gallery_saver.dart'; //保存图片插件
import 'dart:typed_data'; //保存图片插件
import 'package:permission_handler/permission_handler.dart'; //权限插件

import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart'; //toast插件
import 'package:share/share.dart'; //分享功能

class OpenImg extends StatefulWidget{
    final String url;
    // final Function onTap;
    const OpenImg({Key key, this.url}):super(key: key);
    @override
    _OpenImgState createState() => _OpenImgState();
}

class _OpenImgState extends State<OpenImg>{

    void initState(){
        super.initState();
        // 检查并请求权限
        var permission = PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
        print("permission status is " + permission.toString());
        PermissionHandler().requestPermissions(<PermissionGroup>[
            PermissionGroup.storage, // 在这里添加需要的权限--储存权限
        ]);
    }

    //点击保存图片
    // 需要引入一下库
    // import 'package:image_gallery_saver/image_gallery_saver.dart';
    // import 'dart:typed_data';

    void _save() async {
        var response = await Dio().get(widget.url, options: Options(responseType: ResponseType.bytes));
        final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data)
        );
        // 判断ios还是android,故需要引入 import 'dart:io';
        if(Platform.isIOS){
            if(result){
                showToast('成功保存到相册');
            }else{
                showToast('保存失败');
            }
        }else{
            if(result != null){
                showToast('成功保存到相册');
            }else{
                showToast('保存失败');
            }
        }
    }


    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0.0, //导航栏阴影
                actions: [
                    PopupMenuButton(
                        child: Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context){
                            return <PopupMenuItem<String>>[
                                PopupMenuItem<String>(child: Text("下载图片"), value: "download",),
                                PopupMenuItem<String>(child: Text("分享图片"), value: "share",),
                            ];
                        },
                        onSelected: (String action) {
                            switch (action) {
                            case "download":
                                _save();
                                break;
                            case "share":
                                print("分享图片");
                                Share.share('【知乎日报,每天三次,每次七分钟】\n ${widget.url}');
                                break;
                            }
                        },
                        onCanceled: () {
                            print("onCanceled");
                        }
                    )
                ],
            ),
            body: DragScaleContainer(
                doubleTapStillScale: true,
                child: Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height,
                    child: Image.network(this.widget.url),
                ),
            )
        );
    }
}
