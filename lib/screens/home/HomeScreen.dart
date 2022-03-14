import 'package:flutter/material.dart';

import '../../model/userModel.dart';
import 'HomeScreenState.dart';

class HomePage extends StatefulWidget {
  final UserDataModel userData;

  HomePage({Key? key, required this.userData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}
