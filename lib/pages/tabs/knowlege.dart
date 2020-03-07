import 'package:flutter/material.dart';
import 'package:flutter_ncov/http/http_util.dart';
import 'package:flutter_ncov/widgets/loading.dart';
import 'package:flutter_ncov/util/screen_adaper.dart';

class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage>
    with AutomaticKeepAliveClientMixin {
  Future _getData() async {
    var result = await HttpUtils.request('/data/getWikiList');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: _getData(),
          builder: (context, snap) {
            Widget result;
            if (snap.connectionState == ConnectionState.done) {
              List<Widget> list = List<Widget>();
              for (int i = 0; i < snap.data['result'].length; i++) {
                list.add(InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/webview_details',
                        arguments: {
                          'url': snap.data['result'][i]['linkUrl'],
                          'title': snap.data['result'][i]['title']
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      snap.data['result'][i]['imgUrl'] != ''
                          ? Container(
                              width: ScreenAdaper.setWidth(200),
                              height: ScreenAdaper.setHeight(150),
                              margin: EdgeInsets.only(
                                  left: ScreenAdaper.setWidth(20),
                                  bottom: ScreenAdaper.setWidth(24)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      ScreenAdaper.setWidth(10)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${snap.data['result'][i]['imgUrl']}'),
                                      fit: BoxFit.cover)))
                          : SizedBox(),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title:
                                    Text('${snap.data['result'][i]['title']}'),
                                subtitle: Column(children: <Widget>[
                                  SizedBox(height: ScreenAdaper.setHeight(20)),
                                  Text(
                                      '${snap.data['result'][i]['description']}')
                                ]),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenAdaper.setWidth(24)),
                                child: Divider(),
                              )
                            ],
                          )),
                      SizedBox(height: ScreenAdaper.setHeight(20))
                    ],
                  ),
                ));
              }
              result = Column(children: list);
            } else if (snap.connectionState == ConnectionState.waiting) {
              result = Loading();
            }
            return result;
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
