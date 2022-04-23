import 'package:flutter/cupertino.dart';

extension ScreenUtil on BuildContext {
  get screenWidth => MediaQuery.of(this).size.width;
  get screenheight => MediaQuery.of(this).size.height;
}
