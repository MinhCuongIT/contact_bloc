import 'package:flutter/material.dart';

class WaitingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(backgroundColor: Colors.white),
          Text('Vui lòng chờ...', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
