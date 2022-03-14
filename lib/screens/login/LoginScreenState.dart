import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../model/userModel.dart';
import '../home/HomeScreen.dart';
import '../loginSignupSelection/LoginSignupSelectionScreen.dart';
import 'LoginScreen.dart';

class LoginScreenState extends State<LoginScreen> {
  int selectedBottomNavIndex = 0;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        _getPhoneNumberField(),
        _getPasswordField(),
        _getButton(),
        _getSignupButton(),
      ],
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
            return 'Please enter phone number ';
          }
          if (value != null && value.length < 10) {
            return 'invalid phone number';
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
        maxLength: 20,
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
        onPressed: () => {_loginUser()},
        style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            primary: Colors.green),
        child: const Text(
          "LOGIN",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _getSignupButton() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ElevatedButton(
        onPressed: () => {_moveToSignup()},
        style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            primary: Colors.green),
        child: const Text(
          "Signup",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void _moveToSignup() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SignInOutScreen()));
  }

  void _moveToHomeScreen(UserDataModel data) {
    print("_moveToHomeScreen");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  userData: data,
                )));
  }

  void _loginUser() async {
    print("_loginUser");
    var data = await loginUser(_phoneNumber.text, _password.text);
    print(data.token);
    _moveToHomeScreen(data);
  }
} //class




Future<UserDataModel> loginUser(String phone, String password) async {
  const String apiUrl = "http://localhost:3000/login";
  print("fffffffff");
  var response = await http.post(Uri.parse(apiUrl), body: {"phone": phone, "password": password});
  print(response.body);
  if(response.statusCode==200){
    var data = userDataModelFromJson(response.body);
    print("fffffffff333");
    return data;
  }else{
    return UserDataModel();
  }
}


