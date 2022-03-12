import 'package:flutter/material.dart';

import 'HomeScreenState.dart';

class HomePage extends StatefulWidget {
  final String mnemonic;
  final String account;
  final String pubKey;

  HomePage({Key? key, required this.mnemonic, required this.account, required this.pubKey})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}
