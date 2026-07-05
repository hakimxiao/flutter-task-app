import 'package:flutter/animation.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/home/repository/task_remote_repository.dart';
import 'package:frontend/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_task_state.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskState> {
  AddNewTaskCubit() : super(AddNewTaskInitial());
  final taskRemoteRepository = TaskRemoteRepository();

  Future<void> createNewTask({
    required String title,
    required String description,
    required Color color,
    required DateTime dueAt,
    required String token,
  }) async {
    try {
      emit(AddNewTaskLoading());
      final taskModel = await taskRemoteRepository.createTask(
        title: title,
        description: description,
        hexColor: rgbToHex(color),
        dueAt: dueAt,
        token: token,
      );

      emit(AddNewTaskSuccess(taskModel));
    } catch (err) {
      emit(AddNewTaskError(err.toString()));
    }
  }
}
