import 'package:flutter/material.dart';
import 'list_title.dart';
import '../theme/theme_style.dart';



class HomeDrawer extends StatefulWidget {
    @override
    _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
    @override
    Widget build(BuildContext context){
        return Container(
            width: MediaQuery.of(context).size.width * .65,
            decoration: BoxDecoration(color: ThemeStyle.of(context).drawerBackground),
            child: ListView(
                padding: EdgeInsets.zero, //去掉顶部灰色部分
                children: [
                    DrawerHeader(
                        decoration: BoxDecoration(color: ThemeStyle.of(context).drawerHeadBackground),
                        child: UnconstrainedBox( //解除父级的大小限制
                            child: CircleAvatar(
                                radius: 48,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage('assets/images/avatar.png')
                            ),
                        ),
                    ),
                    ListWidget(
                        iconData: Icons.home,
                        title: '首页',
                        onTap: (){
                            Navigator.pop(context);
                        },
                    ),
                    ListWidget(
                        iconData: Icons.notifications,
                        title: '我的信息',
                        onTap: (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, 'notice');
                        },
                    ),
                    ListWidget(
                        iconData: Icons.settings,
                        title: '设置',
                        onTap: (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, 'setting');
                        },
                    ),
                ],
            ),
        );
    }
}