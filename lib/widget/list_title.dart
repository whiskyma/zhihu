import 'package:flutter/material.dart';
import '../theme/theme_style.dart';



class ListWidget extends StatefulWidget{
    final IconData iconData;
    final String title;
    final GestureTapCallback onTap;
    const ListWidget({Key key, this.iconData, this.title, this.onTap}):super(key: key);
    @override
    _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget>{
    Widget build(BuildContext context){
        return GestureDetector(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7,vertical: 4),
                decoration: BoxDecoration(
                    // color: ThemeStyle.of(context).drawerItemSel,
                    border: Border(
                        bottom: BorderSide(width: 1,color: ThemeStyle.of(context).dividerColor)
                    )
                ),
                child: ListTile(
                    title: Text(this.widget.title,style: TextStyle(fontSize: 16.0)),
                    leading: Icon(this.widget.iconData, color: Colors.blue),
                    trailing: Icon(Icons.chevron_right),
                    onTap: this.widget.onTap
                ),
            ),
        );
    }
}
