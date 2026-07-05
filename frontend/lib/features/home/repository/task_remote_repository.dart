import 'dart:convert';

import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteRepository {
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
}
