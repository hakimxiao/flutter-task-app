import 'package:flutter/animation.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/home/repository/task_local_repository.dart';
import 'package:frontend/features/home/repository/task_remote_repository.dart';
import 'package:frontend/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TasksState> {
  TaskCubit() : super(TasksStateInitial());
  final taskRemoteRepository = TaskRemoteRepository();
  final taskLocalRepository = TaskLocalRepository();

  Future<void> createNewTask({
    required String title,
    required String description,
    required Color color,
    required DateTime dueAt,
    required String token,
    required String uid,
  }) async {
    try {
      emit(TasksStateLoading());
      final taskModel = await taskRemoteRepository.createTask(
        uid: uid,
        title: title,
        description: description,
        hexColor: rgbToHex(color),
        dueAt: dueAt,
        token: token,
      );

      await taskLocalRepository.insertTask(taskModel);

      emit(TasksStateSuccess(taskModel));
    } catch (err) {
      emit(TasksStateError(err.toString()));
    }
  }

  Future<void> getAllTasks({required String token}) async {
    try {
      emit(TasksStateLoading());
      final tasks = await taskRemoteRepository.getTasks(token: token);

      emit(GetTasksSuccess(tasks));
    } catch (err) {
      emit(TasksStateError(err.toString()));
    }
  }
}
