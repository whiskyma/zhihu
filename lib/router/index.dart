import 'package:flutter/material.dart';

import 'package:flutter_zhihu/pages/home_page.dart';
import 'package:flutter_zhihu/pages/setting_page.dart';
import 'package:flutter_zhihu/pages/notice_page.dart';
import 'package:flutter_zhihu/pages/news_detail.dart';
import 'package:flutter_zhihu/widget/open_img.dart';




final routes = <String, WidgetBuilder>{
    '/': (ctx) => HomePage(),
    'settingPage': (ctx) => SettingPage(),
    'noticePage': (ctx) => NoticePage(),
    'newsDetail': (ctx) => NewsDetail(),
    'openImg': (ctx) => OpenImg()
};