import 'package:flutter/material.dart';
import '../helpers/api_helpers.dart'; 
import '../models/userModel.dart'; 
import 'todolist.dart'; 

class Registrasi extends StatefulWidget {
  const Registrasi({super.key});

  @override
  State<Registrasi> createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {

  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();[cite_start]
  final _lastNameController = TextEditingController();[cite_start]
  final _ageController = TextEditingController();[cite_start]
  final _emailController = TextEditingController();[cite_start]

bool _isLoading = false; [cite_start]

[cite_start]//aku baru tahu ini fungsi untuk request post

Future<void>_register() async{
  [cite_start]
  if (!_formKey.currentState!.validate()) {
    return;
  }
  [cite_start]
  setState(() {
    _isLoading = true;
  });
  try {
    final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final age = int.tryParse(_ageController.text) ?? 0;
      final email = _emailController.text;
      [cite_start]
      final User registrasiUser = await registerUser(
        firstName: firstName,
       lastName: lastName, 
       age: age, 
       email: email)
  } catch (e) {
    
  }
}
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}