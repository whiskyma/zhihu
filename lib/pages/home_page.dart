import 'package:flutter/material.dart';
import 'package:flutter_zhihu/utils/http.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_zhihu/utils/shared_preferences.dart';
import '../utils/http.dart';
import '../widget/news_item.dart';
import 'news_detail.dart';
import '../widget/home_drawer.dart';
import '../theme/theme_style.dart';
import '../utils/config.dart';
import 'package:cached_network_image/cached_network_image.dart';



class HomePage extends StatefulWidget{
    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

    static List bannerList = List(); //banner列表
    static List newsList = List(); //信息列表
    int curTime = 0; //时间点
    bool isLoading = true;
    double scrollPixels = 0;

    String loadMoreText = "没有更多数据";
    TextStyle loadMoreTextStyle = TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
    TextStyle titleStyle = TextStyle(color: const Color(0xFF757575), fontSize: 14.0);
    ScrollController _controller = ScrollController(); //滑动器

    
    @override
    void initState(){
        super.initState();
        _controller.addListener((){
            // 滚动到底部触发
            if(_controller.position.maxScrollExtent==_controller.position.pixels){
                getNews();
            }else{
                setState(() {
                    scrollPixels = _controller.position.pixels;
                });
            }
        });
        _pullToRefresh();
    }

    @override
    void dispose(){
        super.dispose();
        _controller.dispose();
    }

    // 获取news列表
    void getNews() async {
        if(isLoading){
            try{
                var res = await Http().get('news/before/'+curTime.toString());
                setState((){
                    newsList.addAll(res['stories']);
                    curTime = int.parse(res['date']);
                });
            } catch (e){

            }
        }
        if(newsList.length>120){
            setState(() {
                isLoading = false;
            });
        }
    }

    // 下拉刷新
    Future _pullToRefresh() async {
        if(newsList.isNotEmpty){
            await Future.delayed(Duration(seconds: 1));
        }
        try {
            var res = await Http().get('news/latest');
            if(res.containsKey('top_stories')){
                setState(() {
                    bannerList.clear();
                    newsList.clear();
                    isLoading = true;

                    bannerList = res['top_stories'];
                    newsList.addAll(res['stories']);
                    curTime = int.parse(res['date']);
                });
            }
        } catch (e){
            print(e);
        }
    }

    @override
    Widget build(BuildContext context){
        bool topStoriesIsEmpty = bannerList.isEmpty;
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text('首页',style: TextStyle(color: Colors.white)),
                actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.notifications),
                        color: Colors.white,
                        onPressed: (){
                            Navigator.pushNamed(context, 'noticePage');
                        }
                    ),
                    PopupMenuButton(
                        onSelected: (String value) {
                            if(value=='夜间模式'){
                                if(ThemeStyle.of(context).themeMode==1){
                                    ThemeStyle.set(context, 0);
                                    SharedPreferencesUtils.save(Config.SP_THEME_MODE, 0);
                                }else{
                                    ThemeStyle.set(context, 1);
                                    SharedPreferencesUtils.save(Config.SP_THEME_MODE, 1);
                                }
                                print(ThemeStyle.of(context).themeMode);
                            }
                        },
                        itemBuilder: (context) {
                            return <PopupMenuItem<String>>[
                                PopupMenuItem<String>(
                                    value: "夜间模式",
                                    child: Container(
                                        height: 32,
                                        width: 85,
                                        child: Text(ThemeStyle.of(context).themeMode==1?'日间模式':'夜间模式'),
                                    ),
                                    ),
                                PopupMenuItem<String>(
                                    value: "设置选项",
                                    child: Container(
                                        height: 32,
                                        width: 85,
                                        child: Text("设置选项"),
                                    ),
                                ),
                            ];
                        },
                        child: InkWell(
                            child: Container(
                                padding: EdgeInsets.only(left: 12, right: 12),
                                child: Icon(Icons.more_vert),
                            ),
                        ),
                    )
                ],
                leading: Builder(builder: (context) {
                    return IconButton(
                        icon: Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                            Scaffold.of(context).openDrawer(); 
                        },
                    );
                })
            ),
            drawer: HomeDrawer(),
            drawerEdgeDragWidth: 0,
            floatingActionButton: scrollPixels > 450 ? FloatingActionButton(
                onPressed: () {
                    _controller.animateTo(0, duration: Duration(milliseconds: 100),curve: Curves.ease);
                },
                backgroundColor: Colors.lightBlue,
                child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 26.0,
                ),
            ): null,
            body: RefreshIndicator(
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: newsList.length+1,
                    itemBuilder:(context, index){
                        if(index==0&&!topStoriesIsEmpty){
                            return bannerItem();
                        }
                        final storiesInx = topStoriesIsEmpty ? index : index-1;
                        if(storiesInx == newsList.length-1){
                            return isLoading?_getMoreText():_noMoreText();
                        }else{
                            return newsItem(storiesInx);
                        }
                    },
                    controller: _controller,
                ),
                onRefresh: _pullToRefresh,
            ),
        );
    }

    // 轮播列表
    bannerItem(){
        return bannerList.length>0?Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * .7,
            child: Swiper(
                index: 0,
                loop: true,
                autoplay: true,
                duration: 500,
                itemBuilder: (BuildContext context, int index){
                    return Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                            CachedNetworkImage(
                                imageUrl: '${bannerList[index]['image']}',
                                placeholder: (context, url) => Container(
                                    width: 130,
                                    height: 80,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                        ),
                                    ),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                fit: BoxFit.cover,
                            ),
                            Positioned(
                                bottom: 20,
                                child: Container(
                                    height: 48,
                                    padding: EdgeInsets.symmetric(horizontal: 18),
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                        child: Text(bannerList[index]['title'],
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            height: 1.1,
                                            color: Colors.white,
                                            fontSize: 21
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    );
                },
                // 展示默认分页指示器
                pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.white54,
                        activeColor: Colors.white,
                        size: 7, //圆点大小
                        activeSize: 7, //选中圆点大小
                        space: 2 //点之间的距离
                    )
                ),
                // 条目数
                itemCount: bannerList.length,
                /// 当用户点击某个轮播的时候调用
                onTap: (index) {
                    // print(" 点击 " + index.toString());
                    print("你点击了第$index个"); 
                },
                // 相邻子条目视窗比例
                viewportFraction: 1,
                // 用户进行操作时停止自动翻页
                autoplayDisableOnInteraction: true,
                /// 滚动方向，设置为Axis.vertical如果需要垂直滚动
                scrollDirection: Axis.horizontal,
                //当前条目的缩放比例
                scale: 1,
            ),
        ):_getMoreText();
    }

    // 新闻列表
    newsItem(int index){
        var it = newsList[index];
        return Container(
            child: NewsItemWidget(
                title: it['title'],
                image: it['images'].length>0?it['images'][0]:null,
                onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => NewsDetail(id: it['id'])
                        )
                    );
                }
            ),
        );
    }

    // 加载进度条
    Widget _getMoreText() {
        return Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Padding(
                            padding: EdgeInsets.only(right:10),
                            child: Text('正在努力加载中...',style: titleStyle),
                        ),
                        SizedBox(width: 17,height: 17,child: CircularProgressIndicator(strokeWidth:2))
                    ],
                )
            ),
        );
    }

    // 没有更多数据了
    Widget _noMoreText(){
        return Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
                child: new Text('没有更多数据加载了', style: loadMoreTextStyle),
            ),
        );
    }

}