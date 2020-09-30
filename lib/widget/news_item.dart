import 'package:flutter/material.dart';
import '../theme/theme_style.dart';
import 'package:cached_network_image/cached_network_image.dart';


class NewsItemWidget extends StatefulWidget{
    final String image;
    final String title;
    final Function onTap;
    const NewsItemWidget({Key key, this.image, this.title, this.onTap}):super(key: key);
    @override
    _NewsItemWidgetState createState() => _NewsItemWidgetState();
}

class _NewsItemWidgetState extends State<NewsItemWidget>{
    Widget build(BuildContext context){
        return Container(
            margin: EdgeInsets.symmetric(horizontal:10,vertical:5),
            decoration: BoxDecoration(
                boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, .2),
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0
                    )
                ]
            ),
            child: Material(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                    onTap: this.widget.onTap,
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                                Expanded(
                                    child: Text(this.widget.title,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 17,
                                            height: 1.3,
                                            color: ThemeStyle.of(context).textColorLightLarge
                                        ),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left:10),
                                    child: CachedNetworkImage(
                                        imageUrl: widget.image,
                                        placeholder: (context, url) => Container(
                                            width: 45,
                                            height: 45,
                                            child: Center(
                                                child: CircularProgressIndicator(
                                                    strokeWidth: 2
                                                ),
                                            ),
                                        ),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width: 70,
                                    ),
                                )
                            ],
                        ),
                    )
                ),
            ),
        );
    }
}
