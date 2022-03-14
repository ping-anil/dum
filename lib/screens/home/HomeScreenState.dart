
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomeScreen.dart';

class HomeScreenState extends State<HomePage> {
  int selectedBottomNavIndex = 0;
  String _publicKey = "";
  String _balance = "";
  String? _userPhone = "";

  @override
  void initState() {
    super.initState();
    _publicKey = widget.userData.publicKey.toString();
    _balance = "widget.userData.balance.toString()";
    _userPhone = widget.userData.user?.phone.toString();
    _getAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(), //body
    ); //scaffold
  }

  Widget? getBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Details \n account : $_publicKey \n Balance : $_balance",
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

  }

  void _requestAirDrop() async {
    _initiateAirDrop();
    _getAccountDetails();
  }

  void _initiateAirDrop() async {
    if(_userPhone!=null){
      _initiateAirDropRequest(_userPhone!);
    }
  }

} //class


void _initiateAirDropRequest(String phone) async {
  const String apiUrl = "http://localhost:3000/airDropSol";
  var data = await http.post(Uri.parse(apiUrl), body: {"phone": phone});
}
