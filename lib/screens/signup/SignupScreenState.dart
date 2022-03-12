import 'package:aa/screens/signup/SignupScreen.dart';
import 'package:aa/utils/SecureStorage.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';

import '../home/HomeScreen.dart';

class SignupScreenState extends State<SignupScreen> {
  String _randomMnemonic = "";

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _randomMnemonic = bip39.generateMnemonic();
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
        Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(_randomMnemonic)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                primary: Colors.orange,
                side: const BorderSide(color: Colors.red)),
            onPressed: () => copyText(),
            child: const Text("Copy Text"),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Please save the text above as it will be used to access your account",
          ),
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
          children: [
            _getPasswordField(),
            _getConfirmPasswordField(),
            _getButton()
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

  Widget _getConfirmPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: _confirmPassword,
        obscureText: true,
        keyboardType: TextInputType.text,
        maxLength: 20,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'password mismatch';
          }
          if (_password.text != _confirmPassword.text) {
            return 'password mismatch';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Confirm password',
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

  void copyText() {
    Clipboard.setData(ClipboardData(text: _randomMnemonic)).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Copied to clipboard")));
    });
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState?.validate();
    if (isFormValid == true) {
      _encryptAndSaveCreds();
    }
  }

  void _encryptAndSaveCreds() async {
    final mnemonic = _randomMnemonic;
    final password = _password.text;
    SecureStorage.saveMnemonic(password, mnemonic);
    final pubKeyPair = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
    final address = pubKeyPair.address;
    SecureStorage.saveMnemonic("address", address);
    final pubKey = await pubKeyPair.extractPublicKey();
    SecureStorage.saveMnemonic("pubKey", pubKey.bytes.toString());
    _moveToHomeScreen(mnemonic, address, pubKey.bytes.toString());
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
} //class
