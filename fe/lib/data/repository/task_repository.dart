import 'dart:convert';
import 'package:fe/data/service/task_service.dart';
import 'package:http/http.dart' as http;
import 'package:fe/data/model/task.dart';

class TaskRepository {
  final TaskService taskService;
  TaskRepository({
    required this.taskService,
  });

  Future<List<TaskModel>> getTaskList() async {
    final response = await taskService.getTask();
    if (response!.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final tasks = json.map((e) => TaskModel.fromJson(e)).toList();
      return tasks;
    } else {
      throw Exception('Failed to load Tasks');
    }
  }
}
