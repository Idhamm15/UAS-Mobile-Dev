import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe/bloc/users/bloc/users_event.dart';
import 'package:fe/bloc/users/bloc/users_state.dart';
import 'package:fe/data/repository/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}