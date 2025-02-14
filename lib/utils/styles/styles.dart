import 'package:flutter/cupertino.dart';

import '../constants/sizes.dart';

class TSpacingStyle{
  static const EdgeInsetsGeometry paddingWithAppBarHeight=EdgeInsets.only(
    top: TSizes.appBarHeight,
    bottom: TSizes.defaultSpace,
    left: TSizes.defaultSpace,
    right: TSizes.defaultSpace,
  );
}