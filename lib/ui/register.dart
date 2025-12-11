import 'package:flutter/material.dart';
import 'package:http/http.dart' as fatimah; 
import '../helpers/api_helpers.dart'; 
import '../models/userModel.dart'; 
import 'todolist.dart'; 

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      isLoading = true;
    });

    try {
      final firstName = firstNameController.text;
      final lastName = lastNameController.text;
      final age = int.parse(ageController.text); 
      final email = emailController.text;

      // Pemanggilan registerUser tanpa password
      final User registeredUser = await registerUser(
        firstName: firstName,
        lastName: lastName,
        age: age,
        email: email,
      );

      final registeredName = registeredUser.firstName + ' ' + registeredUser.lastName;
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil Mendaftar: $registeredName'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TodolistPage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal: ${e.toString()}'), 
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          )
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Registrasi')),
      backgroundColor: Color.fromARGB(255, 232, 245, 173),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Form( 
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "REGISTRASI PENGGUNA BARU",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // Input Field 1: First Name
                _buildInput(firstNameController, "First Name", TextInputType.text),

                // Input Field 2: Last Name
                _buildInput(lastNameController, "Last Name", TextInputType.text),

                // Input Field 3: Age
                _buildInput(ageController, "Age", TextInputType.number, isAge: true),

                // Input Field 4: Email
                _buildInput(emailController, "Email", TextInputType.emailAddress, isEmail: true),
                
                // Input Password telah dihapus

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _register, 
                    style: ElevatedButton.styleFrom(
                     backgroundColor: Color(0xFF004269),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading 
                      ? const CircularProgressIndicator(color: Colors.white,) 
                      : const Text(
                          "Register",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ), 
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller, 
    String hintText, 
    TextInputType keyboardType, 
    {
      bool isAge = false, 
      bool isEmail = false, 
      bool obscureText = false // Dibiarkan jika ada input sensitif di masa depan, tapi saat ini selalu false
    }
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        // Dibuat selalu false karena password field sudah dihapus.
        // Jika Anda ingin field lain disembunyikan, set parameter ini menjadi true saat memanggil _buildInput
        obscureText: obscureText, 
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hintText wajib diisi';
          }
          if (isAge) {
            final age = int.tryParse(value);
            if (age == null || age <= 0) {
              return 'Age harus berupa angka positif';
            }
          }
          if (isEmail) {
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Masukkan email yang valid';
            }
          }
          return null;
        },
      ),
    );
  }
}