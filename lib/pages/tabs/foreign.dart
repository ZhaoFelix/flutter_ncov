import 'package:flutter/material.dart';
import '../../http/http_util.dart';
import '../../widgets/loading.dart';
import 'package:flutter_ncov/widgets/my_title.dart';
import 'package:flutter_ncov/util/screen_adaper.dart';

class ForeignPage extends StatefulWidget {
  @override
  _ForeignPageState createState() => _ForeignPageState();
}

class _ForeignPageState extends State<ForeignPage>
    with AutomaticKeepAliveClientMixin {
  Future _getData() async {
    var result = await HttpUtils.request('/data/getListByCountryTypeService2');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MyTitle(title: '统计'),
          Container(
            height: ScreenAdaper.setHeight(70),
            color: Colors.lightBlueAccent[100],
            child: Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                      child: Text('国家/地区',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: ScreenAdaper.setWidth(28))))),
              Expanded(
                  flex: 1,
                  child: Container(
                      child: Text('现有确诊',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: ScreenAdaper.setWidth(28))))),
              Expanded(
                  flex: 1,
                  child: Container(
                      child: Text('累计确诊',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ScreenAdaper.setWidth(28),
                          )))),
              Expanded(
                  flex: 1,
                  child: Container(
                      child: Text('死亡',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: ScreenAdaper.setWidth(28))))),
              Expanded(
                  flex: 1,
                  child: Container(
                      child: Text('治愈',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: ScreenAdaper.setWidth(28))))),
            ]),
          ),
          FutureBuilder(
              future: this._getData(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                Widget result;
                if (snap.connectionState == ConnectionState.done) {
                  List<Widget> list = List<Widget>();
                  print(snap.data.length);
                  for (int i = 0; i < snap.data.length; i++) {
                    list.add(DataRow(data: snap.data[i]));
                  }
                  result = Column(children: list);
                } else if (snap.connectionState == ConnectionState.waiting) {
                  result = Loading();
                }
                return result;
              }),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataRow extends StatefulWidget {
  final data;
  DataRow({this.data});
  @override
  _DataRowState createState() => _DataRowState();
}

class _DataRowState extends State<DataRow> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Animation _animationHeight;
  Future _future;
  bool _isUnfold = false;

  Future _getData() async {
    var result = HttpUtils.request(
        '/data/getAreaStat/${widget.data['provinceShortName']}');
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    this._animation =
        Tween(begin: 0.0, end: 0.25).animate(this._animationController);
    this._animationHeight =
        Tween(begin: 0.0, end: 1.0).animate(this._animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenAdaper.setHeight(70),
          color: Colors.grey[100],
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.only(left: ScreenAdaper.setWidth(10)),
                    child: Text(
                      '${widget.data['provinceName']}',
                      textAlign: TextAlign.center,
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    child: Text(
                  '${widget.data['currentConfirmedCount']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange),
                )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    child: Text(
                  '${widget.data['confirmedCount']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    child: Text(
                  '${widget.data['deadCount']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    child: Text(
                  '${widget.data['curedCount']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                )),
              ),
            ],
          ),
        ),
        Divider(height: 0.5)
      ],
    );
  }
}
