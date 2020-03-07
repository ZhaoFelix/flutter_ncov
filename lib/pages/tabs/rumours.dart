import 'package:flutter/material.dart';
import 'package:flutter_ncov/http/http_util.dart';
import 'package:flutter_ncov/widgets/loading.dart';
import 'package:flutter_ncov/widgets/my_title.dart';
import 'package:flutter_ncov/util/screen_adaper.dart';
import 'package:date_format/date_format.dart';

class RumoursPage extends StatefulWidget {
  @override
  _RumoursPageState createState() => _RumoursPageState();
}

class _RumoursPageState extends State<RumoursPage>
    with AutomaticKeepAliveClientMixin {
  Map _info = {};
  bool _isSuccess = false;

  void _getData() async {
    var result = await HttpUtils.request('/data/getStatisticsService');
    setState(() {
      this._info = result;
      this._isSuccess = true;
    });
  }

  Future _getRumourData() async {
    var result = await HttpUtils.request('/data/getIndexRumorList');
    return result;
  }

  List<Widget> _getMaps() {
    List<Widget> list = [];
    for (int i = 0; i < this._info['dailyPics'].length; i++) {
      list.add(Image.network('${this._info['dailyPics'][i]}'));
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getData();
  }

  @override
  Widget build(BuildContext context) {
    return this._isSuccess
        ? SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MyTitle(
                  title: '全国统计',
                  subtitle:
                      '更新时间：${formatDate(DateTime.fromMillisecondsSinceEpoch(this._info['modifyTime']), [
                    yyyy,
                    '-',
                    mm,
                    '-',
                    dd,
                    ' ',
                    HH,
                    ':',
                    nn
                  ])}',
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenAdaper.setWidth(20),
                        vertical: ScreenAdaper.setWidth(14)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('${this._info['confirmedCount']}',
                                style: TextStyle(
                                    fontSize: ScreenAdaper.setWidth(38),
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w700)),
                            Text(
                              '全国确诊',
                              style: TextStyle(
                                  fontSize: ScreenAdaper.setWidth(26)),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('${this._info['suspectedCount']}',
                                style: TextStyle(
                                    fontSize: ScreenAdaper.setWidth(38),
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.w700)),
                            Text(
                              '疑似病例',
                              style: TextStyle(
                                  fontSize: ScreenAdaper.setWidth(26)),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('${this._info['curedCount']}',
                                style: TextStyle(
                                    fontSize: ScreenAdaper.setWidth(38),
                                    color: Colors.green,
                                    fontWeight: FontWeight.w700)),
                            Text(
                              '治愈人数',
                              style: TextStyle(
                                  fontSize: ScreenAdaper.setWidth(26)),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('${this._info['deadCount']}',
                                style: TextStyle(
                                    fontSize: ScreenAdaper.setWidth(38),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700)),
                            Text(
                              '死亡人数',
                              style: TextStyle(
                                  fontSize: ScreenAdaper.setWidth(26)),
                            )
                          ],
                        ),
                      ],
                    )),
                Divider(),
                MyTitle(
                  title: '疫情地图',
                  subtitle: '数据来源：国家及各省市地区卫健委',
                ),
                Image.network('${this._info['imgUrl']}'),
                Column(
                  children: this._getMaps(),
                ),
                MyTitle(
                  title: '辟谣',
                  subtitle: '消息数量：10',
                ),
                FutureBuilder(
                    future: this._getRumourData(),
                    builder: (context, snap) {
                      Widget result;
                      if (snap.connectionState == ConnectionState.done) {
                        List<Widget> list = List<Widget>();
                        for (int i = 0; i < snap.data.length; i++) {
                          list.add(RumourBuild(data: snap.data[i]));
                        }
                        result = Column(children: list);
                      } else if (snap.connectionState ==
                          ConnectionState.waiting) {
                        result = Loading();
                      }
                      return result;
                    })
              ],
            ),
          )
        : Loading();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class RumourBuild extends StatefulWidget {
  final data;
  RumourBuild({this.data});
  @override
  _RumourBuildState createState() => _RumourBuildState();
}

class _RumourBuildState extends State<RumourBuild> {
  bool _showDetails = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(ScreenAdaper.setWidth(20)),
      padding: EdgeInsets.all(ScreenAdaper.setWidth(15)),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
          borderRadius: BorderRadius.circular(ScreenAdaper.setWidth(10))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Text(
          '${widget.data['title']}',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenAdaper.setWidth(32),
          ),
        ),
        SizedBox(height: ScreenAdaper.setHeight(10)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(ScreenAdaper.setWidth(15)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenAdaper.setWidth(10)),
              color: Color.fromRGBO(255, 255, 255, 0.8)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Text('${widget.data['mainSummary']}',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenAdaper.setWidth(30))),
            SizedBox(height: ScreenAdaper.setHeight(30)),
            Visibility(
                visible: !this._showDetails,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      this._showDetails = true;
                    });
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('展开详情', style: TextStyle(color: Colors.black45)),
                        Icon(Icons.keyboard_arrow_down, color: Colors.black45)
                      ]),
                )),
            Visibility(
                visible: this._showDetails,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${widget.data['body']}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenAdaper.setWidth(26))),
                      SizedBox(height: ScreenAdaper.setHeight(20)),
                      InkWell(
                        onTap: () {
                          setState(() {
                            this._showDetails = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '收起详情',
                              style: TextStyle(color: Colors.black45),
                            ),
                            Icon(Icons.keyboard_arrow_up, color: Colors.black45)
                          ],
                        ),
                      )
                    ]))
          ]),
        )
      ]),
    );
  }
}
