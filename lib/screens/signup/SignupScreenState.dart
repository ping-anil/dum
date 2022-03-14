import 'package:aa/screens/signup/SignupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert' as convert;
import '../../model/userModel.dart';
import '../home/HomeScreen.dart';

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: getBody(),
      ), //body
    ); //scaffold
  }

  Widget? getBody() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Wallet creation is free",
        ),
        Container(
          height: 150,
          child: Lottie.asset('lottieFiles/splash_wallet.json'),
        ),
        _getForm(),
      ],
    ));
  }

  Widget _getForm() {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_getPhoneNumberField(), _getPasswordField(), _getButton()],
        ));
  }

  Widget _getPhoneNumberField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: _phoneNumber,
        keyboardType: TextInputType.phone,
        maxLength: 10,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Please enter username ';
          }
          if (value != null && value.length < 10) {
            return 'invalid number';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter phone number',
        ),
      ),
    );
  }

  Widget _getPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: _password,
        obscureText: true,
        keyboardType: TextInputType.text,
        maxLength: 10,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Please enter password';
          }
          if (value != null && value.length < 4) {
            return 'password must contain 4 characters';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter password',
        ),
      ),
    );
  }

  Widget _getButton() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ElevatedButton(
        onPressed: () => {_submitForm(_phoneNumber.text, _password.text)},
        style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            primary: Colors.green),
        child: const Text(
          "Create Account",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void _submitForm(String phone, String password) {
    final isFormValid = _formKey.currentState?.validate();
    if (isFormValid == true) {
      _createUser(phone, password);
    }
  }

  void _createUser(String phone, String password) async {
    UserDataModel _data = await _createUserRequest(phone, password);
    _moveToHomeScreen(_data);
  }

  void _moveToHomeScreen(UserDataModel data) {
    print("data.toString()");
    // print(data.toString());
    // print(data.user.toString());
    // print(data.publicKey.toString());
    // print(data.balance.toString());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  userData: data,
                )));
  }
} //class

Future<UserDataModel> _createUserRequest(String phone, String password) async {
  const String apiUrl = "http://localhost:3000/signup";
  var response = await http.post(Uri.parse(apiUrl), body: {"phone": phone, "password": password});
  print(response.body);
  if(response.statusCode==200){
    var data = userDataModelFromJson(response.body);
    return data;
  }else{
    print("parsing error");
    return UserDataModel();
  }
}
