import 'package:aa/utils/SolanaNetwork.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/solana_client.dart';

import 'HomeScreen.dart';

class HomeScreenState extends State<HomePage> {
  int selectedBottomNavIndex = 0;
  String _publicKey = "";
  String _owner = "";
  String _account = "";
  String _mnemonic = "";
  String _balance = "";

  @override
  void initState() {
    super.initState();
    _publicKey = widget.pubKey;
    _account = widget.account;
    _mnemonic = widget.mnemonic;
    _getAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavDrawer(),
      // appBar: HomeAppBar(),
      body: getBody(), //body
      // bottomNavigationBar: getBottomNavBar() //bottom navigation bar
    ); //scaffold
  }

  Widget? getBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Details \n account : $_account \n Balance : $_balance \n Pubkey: $_publicKey \n owner \n _owner",
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: MaterialButton(
            minWidth: double.infinity,
            height: 60,
            onPressed: () {
              _requestAirDrop();
            },
            color: Color(0xFF596EDB),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Text(
              "AirDrop",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        )
      ],
    ));
  }

  void _getAccountDetails() async {
    _getBalance(_account);
    String s = "acc($_account)  bal($_balance) <--> owner($_owner)";
    _getBalance(_publicKey);
    s = s + "acc($_account)  bal($_balance) <--> owner($_owner)";
    Clipboard.setData(ClipboardData(text: s))
        .then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Copied to clipboard")));
    });
    setState(() {
      _account;
      _mnemonic;
      _balance;
      _owner;
    });
  }

  void _getBalance(String balance) async {

    final solanaClient = SolanaClient(
        rpcUrl: Uri.parse(SolanaNetwork.Current.rpc),
      websocketUrl: Uri.parse(SolanaNetwork.Current.ws)
    );

    final rpc = solanaClient.rpcClient;
    final info = await rpc.getAccountInfo(_account);
    final ownerString = info?.owner.toString();
    _owner = ownerString!;
    if (info == null) {
      _balance = "0";
    } else {
      _balance = info.lamports.toString();
    }
  }

  void _requestAirDrop() async {
    _getAccountDetails();
  }
} //class
