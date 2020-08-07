import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_chat_app/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: kTextColor,
      size: 40.0,
    );
  }
}
