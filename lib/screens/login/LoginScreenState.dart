import 'package:aa/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';

import '../home/HomeScreen.dart';
import '../loginSignupSelection/LoginSignupSelectionScreen.dart';
import 'LoginScreen.dart';

class LoginScreenState extends State<LoginScreen> {
  int selectedBottomNavIndex = 0;
  final TextEditingController _password = TextEditingController();

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
        _getPasswordField(),
        _getButton(),
        _getSignupButton(),
      ],
    ));
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
          if (value != null && value.length < 8) {
            return 'password must contain 8 characters';
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
        onPressed: () => {_submitForm()},
        style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            primary: Colors.green),
        child: const Text(
          "PROCEED",
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

  void _moveToHomeScreen(String mnemonic, String address, String pubKey) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  mnemonic: mnemonic,
                  account: address,
                  pubKey: pubKey,
                )));
  }

  void _submitForm() async {
    final mnemonic = await SecureStorage.getSavedMnemonic(_password.text);
    if (mnemonic == null || mnemonic.isEmpty) {
      Clipboard.setData(ClipboardData(text: "invalid 123")).then((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("invalid")));
      });
    } else {
      final pubKeyPair = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
      final address = pubKeyPair.address;
      final pubKey = await pubKeyPair.extractPublicKey();
      _moveToHomeScreen(mnemonic, address, pubKey.bytes.toString());
      Clipboard.setData(ClipboardData(text: "mnemonic ($mnemonic)  ;;;  pk($pubKeyPair)")).then((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("done")));
      });
    }
  }
} //class
