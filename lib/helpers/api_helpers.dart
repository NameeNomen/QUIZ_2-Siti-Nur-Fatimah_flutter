import 'dart:convert';
import 'package:http/http.dart' as fatimah;
import '../models/todolistModel.dart';
import '../models/userModel.dart';

// class ApiHelper {
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
Future<Todo> buatTodo({
  required String todoText,
  required int userId,
})async{
  var url = Uri.parse('$URL/todos/add');

  try{
    var reaksi= await fatimah.post( url,
    headers: _header,
    body:jsonEncode({
      'todo':todoText,
      'completed':false,
      'userId':userId,
    }),
    
     );
     if (reaksi.statusCode==200 || reaksi.statusCode ==2001) {
      Map<String, dynamic> json = jsonDecode(reaksi.body);
      return Todo.fromMap(json);
    }else{
      throw Exception("gagal buat todolistl. Status code: ${reaksi.statusCode}");
    }
  } catch (e) {
      throw Exception("gagal ngepost $e");
    
  }
  }
  Future<Todo> perbaharuiTodo(int id, bool newCompletedStatus)async{
    var url =Uri.parse('$URL/todos/$id');

    try{
      var reaksi = await fatimah.put(
      url,
      headers:_header,
      body:jsonEncode({
        'completed':newCompletedStatus,
      }),);
      if (reaksi.statusCode==200) {
      Map<String, dynamic> json = jsonDecode(reaksi.body);
      return Todo.fromMap(json);
    }else{
      throw Exception("gagal perbaharui todolist. $id Status code: ${reaksi.statusCode}");
    }
  } catch (e) {
      throw Exception("gagal ngeperbaharui $e");
    
    }

  }

  Future<bool> hapusTodo(int id)async{
    var url = Uri.parse('$URL/todos/$id');

       try{
      var reaksi = await fatimah.delete(url);
      if (reaksi.statusCode==200) {
      Map<String, dynamic> json = jsonDecode(reaksi.body);
      return true;
    }else{
      throw Exception("gagal ngedelete todolist nya. $id Status code: ${reaksi.statusCode}");
    }
  } catch (e) {
      throw Exception("gagal nge delete $e");
    
    
    }
}


