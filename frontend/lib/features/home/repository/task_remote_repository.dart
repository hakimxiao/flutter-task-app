import 'dart:convert';

import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/features/home/repository/task_local_repository.dart';
import 'package:frontend/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteRepository {
  final taskLocalRepository = TaskLocalRepository();

  Future<TaskModel> createTask({
    required String title,
    required String description,
    required String hexColor,
    required DateTime dueAt,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.backendUrl}/task'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: jsonEncode({
          'title': title,
          'description': description,
          'hexColor': hexColor,
          'dueAt': dueAt.toIso8601String(),
        }),
      );

      if (response.statusCode != 201) {
        throw jsonDecode(response.body)['error'];
      }

      return TaskModel.fromJson(response.body);
    } catch (err) {
      rethrow;
    }
  }

  Future<List<TaskModel>> getTasks({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.backendUrl}/task'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      if (response.statusCode != 200) {
        final decodedBody = jsonDecode(response.body);
        throw decodedBody is Map<String, dynamic>
            ? decodedBody['error'] ?? decodedBody['msg'] ?? response.body
            : response.body;
      }

      final decodedBody = jsonDecode(response.body);
      final listOfTasks = decodedBody is List
          ? decodedBody
          : decodedBody is Map<String, dynamic> && decodedBody['tasks'] is List
          ? decodedBody['tasks'] as List
          : <dynamic>[];
      List<TaskModel> taskList = [];

      for (var element in listOfTasks) {
        taskList.add(TaskModel.fromMap(element as Map<String, dynamic>));
      }

      await taskLocalRepository.insertTasks(taskList);

      return taskList;
    } catch (err) {
      final tasks = await taskLocalRepository.getTasks();
      if (tasks.isNotEmpty) {
        return tasks;
      }
      rethrow;
    }
  }
}
