import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            const Text('First Name'),
            const Text('Last Name'),
            const Text('Email '),
            const Text('Password'),
            const Text('Mobile'),
            const Text('Address'),
          ],
        ),
      ),
    );
  }
}
