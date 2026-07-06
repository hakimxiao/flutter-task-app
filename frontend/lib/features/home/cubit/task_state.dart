part of 'task_cubit.dart';

sealed class TasksState {
  const TasksState();
}

final class TasksStateInitial extends TasksState {}

final class TasksStateLoading extends TasksState {}

final class TasksStateError extends TasksState {
  final String error;
  TasksStateError(this.error);
}

final class TasksStateSuccess extends TasksState {
  final TaskModel taskModel;

  const TasksStateSuccess(this.taskModel);
}

final class GetTasksSuccess extends TasksState {
  final List<TaskModel> tasks;
  const GetTasksSuccess(this.tasks);
}
