import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;

    return Center(
      child: Container(
        padding: EdgeInsets.all(20 * rpx),
        //设置加载的动画类型
        child: SpinKitThreeBounce(
            color: Theme.of(context).accentColor, size: 100 * rpx),
      ),
    );
  }
}
