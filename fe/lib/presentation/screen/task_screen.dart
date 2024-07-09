// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fe/bloc/task/bloc/task_bloc.dart'; // Adjust with your actual import path

// class TaskScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Management'),
//       ),
//       body: BlocBuilder<TaskBloc, TaskState>(
//         builder: (context, state) {
//           print('Current state: $state');

//           if (state is Loading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is LoadedState) {
//             if (state.tasks.isNotEmpty) {
//               return RefreshIndicator(
//                 onRefresh: () async {
//                   context.read<TaskBloc>().add(PullToRefreshEvent());
//                 },
//                 child: ListView.builder(
//                   itemCount: state.tasks.length,
//                   itemBuilder: (context, index) {
//                     final task = state.tasks[index];
//                     return ListTile(
//                       title: Text(task.title),
//                       subtitle: Text(task.description),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.edit),
//                             onPressed: () {
//                               // Implement edit task
//                             },
//                           ),
//                           // IconButton(
//                           //   icon: Icon(Icons.delete),
//                           //   onPressed: () {
//                           //     context.read<TaskBloc>().add(DeleteTask(task.id));
//                           //   },
//                           // ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               );
//             } else {
//               return Center(child: Text('No tasks available'));
//             }
//           } else if (state is FailedToLoadState) {
//             return Center(child: Text('Failed to load tasks: ${state.message}'));
//           } else {
//             return Center(child: Text('Unknown state'));
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Implement add task
//           // Example: Navigator.pushNamed(context, '/add_task');
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskScreen extends StatelessWidget {
  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('http://localhost:8080/tasks'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('http://localhost:8080/tasks/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: FutureBuilder<List<Task>>(
        future: fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Task task = snapshot.data![index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditTaskScreen(task: task)),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          try {
                            await deleteTask(task.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Task deleted successfully')),
                            );
                            // Refresh task list after deletion
                            (context as Element).reassemble();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to delete task')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;
  final UserModel user;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user.toJson(),
    };
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

Future<void> createTask() async {
  print('Creating task with:');
  print('Title: ${_titleController.text}');
  print('Description: ${_descriptionController.text}');

final response = await http.post(
  Uri.parse('http://localhost:8080/tasks'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'userId': 1, // Sesuaikan dengan pengguna yang sedang aktif
    'title': _titleController.text,
    'description': _descriptionController.text,
    'createdAt': DateTime.now().toUtc().toIso8601String(),
    'updatedAt': DateTime.now().toUtc().toIso8601String(),
    'user': {
      'id': 1, // Sesuaikan dengan pengguna yang sedang aktif
      'name': 'User', // Sesuaikan dengan nama pengguna
      'email': 'owner@go.id', // Sesuaikan dengan email pengguna
    },
  }),
);

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode != 201) {
    throw Exception('Failed to create task');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add New Task',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await createTask();
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add task: $e')),
                  );
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    super.initState();
  }

  Future<void> updateTask() async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/tasks/${widget.task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        // 'userId': widget.task.userId,
        'userId': widget.task.userId,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'createdAt': widget.task.createdAt,
        'updatedAt': DateTime.now().toUtc().toIso8601String(),
        'user': {
          'id': 1, // Sesuaikan dengan pengguna yang sedang aktif
          'name': 'User', // Sesuaikan dengan nama pengguna
          'email': 'owner@go.id', // Sesuaikan dengan email pengguna
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Edit Task with ID: ${widget.task.id}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await updateTask();
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update task')),
                  );
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
