import 'dart:convert';
import 'package:http/http.dart' as fatimah;
import '../models/todolistModel.dart';
import '../models/userModel.dart';

class ApiHelper {
  const String URL='http://dummyjson.com';
final Map<String, String> _header ={
  "Content-Type": "application/json",
};

Future<User> registerUser({
  required String firstName,
  required String lastName,
  required int age,
  required email,

}) async {
  var url = Uri.parse('$URL/users/add');
  try {
    print('sedang mengirim data registerasi, Harap sabar');
    var reaksi = await fatimah.post(body: url,
    header: _header,
    body:jsonEncode)
  } catch (e) {
    
  }
}
}