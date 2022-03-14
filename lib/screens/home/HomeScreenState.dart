import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/userModel.dart';
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
    if (widget.userData.user == null && widget.userData.user?.balance == null) {
      _balance = "0";
    } else {
      _balance = widget.userData.user!.balance!.toString();
    }
    _userPhone = widget.userData.user?.phone.toString();
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

  void _requestAirDrop() async {
    if (_userPhone != null) {
      _initiateAirDropRequest(_userPhone!);
    }
  }


} //class


Future<UserDataModel> _initiateAirDropRequest(String phone) async {
  print("sssssss");
  const String apiUrl = "http://localhost:3000/airDropSol";
  var response = await http.post(Uri.parse(apiUrl), body: {"phone": phone});
  print(response.body);
  if(response.statusCode==200){
    var data = userDataModelFromJson(response.body);
    return data;
  }else{
    return UserDataModel();
  }
}

