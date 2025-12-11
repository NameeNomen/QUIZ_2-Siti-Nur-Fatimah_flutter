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
    var reaksi = await fatimah.post(
      url,
    headers: _header,
    body:jsonEncode({
      'firstName': firstName,
      'lastName':lastName,
      'age':age,
      'email':email
    }),
    );
    if (reaksi.statusCode==200 || reaksi.statusCode ==2001) {
      Map<String, dynamic> json = jsonDecode(reaksi.body);
      return User.fromMap(json);
    }else{
      throw Exception("Registrasi gagal. Status code: ${reaksi.statusCode}");
    }
  } catch (e) {
      throw Exception("gagal ngepost $e");
    
  }
}
Future<List<Todo>> AmbilDataTodo()async{
  var url=Uri.parse('$URL/todos');
  try {
     var reaksi = await fatimah.get(url); 
     if (reaksi.statusCode==200) {
       final data =jsonDecode(reaksi.body);
       final List<dynamic> todosJson = data['todos'];
       return todosJson.map((json)=>Todo.fromMap(json)).toList();
     }else{
      throw Exception("sabar yah ttodonya gagal di muat Status code:${reaksi.statusCode}");
     }
  } catch (e) {
    throw Exception("apalagi ini getnya gagal memuat (Todos)$e");
    }
}
Future<Todo
}