import 'package:flutter/material.dart';
import '../helpers/api_helpers.dart'; 
import '../models/todolistModel.dart'; 

class TodolistPage extends StatelessWidget {
  const TodolistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todosFuture = AmbilDataTodo();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("isiann"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Todo>>( 
        future: todosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("data gagal di muat,sabar: ${snapshot.error}"));
          }
          
          if (snapshot.hasData) {
            List<Todo> todos = snapshot.data!;
            
            if (todos.isEmpty) {
                return const Center(child: Text("todolistnya opso"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todoItem = todos[index];
                final isCompleted = todoItem.completed;
                
                final color = isCompleted ? Colors.green.shade800 : Colors.red.shade800;
                final icon = isCompleted ? Icons.check_box : Icons.close;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(icon, color: color, size: 36),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todoItem.todo,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: color,
                                decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),

                            Text(
                              "Status: ${isCompleted ? 'Selesai' : 'Belum Selesai'}",
                              style: TextStyle(
                                fontSize: 14,
                                color: color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("User ID: ${todoItem.userId}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }

          return const Center(child: Text("terjadi kesalahan yang, yah... begitulah"));
        },
      ),
    );
  }
}