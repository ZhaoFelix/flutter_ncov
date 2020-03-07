import 'package:flutter/material.dart';
import 'package:flutter_ncov/util/screen_adaper.dart';

class StatementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('说明')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(ScreenAdaper.setWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('应用说明',
                  style: TextStyle(fontSize: ScreenAdaper.setWidth(36))),
              SizedBox(height: ScreenAdaper.setHeight(10)),
              Text(
                  '       本应用学习了类似的开源程序，相关的API的接口来源于网络上免费的开源接口。后续如有需要将部署自己的API。'),
              SizedBox(height: ScreenAdaper.setHeight(10)),
              Text('       由于应用中的相关数据来源于免费的数据接口，所以可能存在延时更新和误差，望谅解！'),
              SizedBox(height: ScreenAdaper.setHeight(15)),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('特此感谢以下几位大佬的开源：',
                        style: TextStyle(
                            fontSize: ScreenAdaper.setWidth(28),
                            color: Colors.redAccent)),
                    SizedBox(height: ScreenAdaper.setHeight(12)),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: '数据接口：'),
                      TextSpan(
                          text:
                              'https://github.com/programmerauthor/spread-information',
                          style: TextStyle(color: Colors.blue))
                    ])),
                    SizedBox(height: ScreenAdaper.setHeight(12)),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: '参考项目1：\n'),
                      TextSpan(
                          text: 'https://github.com/LiangWuCode/2019-nCoV',
                          style: TextStyle(color: Colors.blue))
                    ])),
                    SizedBox(height: ScreenAdaper.setHeight(15)),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: '参考项目2：\n'),
                      TextSpan(
                          text: 'https://github.com/BenXi630/flutter_ncov',
                          style: TextStyle(color: Colors.blue))
                    ])),
                  ]),
              SizedBox(height: ScreenAdaper.setHeight(20)),
              Text(
                '愿疫情早日结束！🙏🙏🙏',
                style: TextStyle(fontSize: ScreenAdaper.setWidth(40)),
              ),
              SizedBox(height: ScreenAdaper.setHeight(10)),
              Image.asset(
                'assets/img.jpg',
              ),
              SizedBox(height: ScreenAdaper.setHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}
