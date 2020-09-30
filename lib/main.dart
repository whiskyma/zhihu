import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './router/index.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'theme/theme_style.dart';
import 'utils/shared_preferences.dart';
import 'utils/config.dart';


void main() {
    runApp(MyApp());
    if(Platform.isAndroid){ // 设置状态栏背景及颜色
        SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
}

class MyApp extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _MyAppState();
    }
}

class _MyAppState extends State<MyApp> {
    int themeMode;
    ThemeStyle themeStyle; //实例化ThemeStyle

    @override
    void initState(){
        super.initState();
        getThemeMode();

    }

    void getThemeMode() async {
        themeMode =  await SharedPreferencesUtils.get(Config.SP_THEME_MODE);
        print(themeMode);
    }

    @override
    Widget build(BuildContext context) {
        themeStyle = ThemeStyle(themeMode);
        return ScopedModel(
            model: themeStyle,
            child: ScopedModelDescendant<ThemeStyle>(
                builder: (context, child, model) {
                    return OKToast(
                        position: ToastPosition.bottom,
                        radius: 4.0,
                        textStyle: TextStyle(fontSize: 16),
                        backgroundColor: Colors.black.withOpacity(0.7),
                        child: MaterialApp(
                            theme: model.themeStyleData.themeData,
                            title: 'zhihu',
                            debugShowCheckedModeBanner: false,
                            routes: routes,
                        ),
                    );
                }
            ),
        );
    }





}