import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/app_color.dart';

class CommonLoading extends StatelessWidget {
  final Color? color;
  const CommonLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: color ?? AppColor.white,
        size: 40,
      ),
    );
  }
}
