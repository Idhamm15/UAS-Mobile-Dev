part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

class PullToRefreshEvent extends TaskEvent {}
