import 'package:flutter/material.dart';
import 'package:flutter_ncov/util/screen_adaper.dart';
import 'home.dart';
import 'fence.dart';
import 'rumours.dart';
import 'knowlege.dart';
import 'foreign.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _current = 0;
  PageController _pageController;
  List<String> _titles = ['实时资讯', '国内疫情', '防护指南', '全球疫情', '疾病知识'];
  List<Widget> _pages = [
    HomePage(),
    RumoursPage(),
    FencePage(),
    ForeignPage(),
    KnowledgePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _current);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${_titles[_current]}'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/statement');
              },
              child: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ) //Text('说明', style: TextStyle(color: Colors.white)),
              )
        ],
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black54,
        currentIndex: this._current,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() {
            this._current = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.sentiment_satisfied), title: Text('实时资讯')),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), title: Text('国内疫情')),
          BottomNavigationBarItem(icon: Icon(Icons.spa), title: Text('防护指南')),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), title: Text('全球疫情')),
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_horizontal_circle), title: Text('疾病知识'))
        ],
      ),
    );
  }
}
