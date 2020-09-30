import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/setting_page.dart';
import '../pages/notice_page.dart';
import '../pages/news_detail.dart';
import '../widget/open_img.dart';




final routes = <String, WidgetBuilder>{
    '/': (ctx) => HomePage(),
    'settingPage': (ctx) => SettingPage(),
    'noticePage': (ctx) => NoticePage(),
    'newsDetail': (ctx) => NewsDetail(),
    'openImg': (ctx) => OpenImg()
};