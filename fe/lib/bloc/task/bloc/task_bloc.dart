import 'package:bloc/bloc.dart';
import 'package:fe/data/model/task.dart';
import 'package:fe/data/repository/task_repository.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

   TaskBloc({required this.taskRepository}) : super(TaskInitial()) {
    on<TaskEvent>((event, emit) async {
      if (event is LoadTaskEvent || event is PullToRefreshEvent) {
        emit(Loading());
        try {
          final tasks = await taskRepository.getTaskList();
          emit(LoadedState(tasks: tasks));
        } catch (e) {
          emit(FailedToLoadState(message: e.toString()));
        }
      }
    });
  }
}

// Menghapus inisialisasi TaskRepository dan TaskBloc di luar kelas TaskBloc