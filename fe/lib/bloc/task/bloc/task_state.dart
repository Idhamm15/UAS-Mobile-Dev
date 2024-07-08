part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class Loading extends TaskState {}

final class LoadedState extends TaskState {
  final List<TaskModel> tasks;
  LoadedState({
    required this.tasks
  });
}

class FailedToLoadState extends TaskState {
  final String message;
  FailedToLoadState({required this.message});
}
