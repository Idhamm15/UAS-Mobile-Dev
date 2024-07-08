import 'package:bloc/bloc.dart';
import 'package:fe/bloc/login/bloc/login_event.dart';
import 'package:fe/bloc/login/bloc/login_state.dart';
import 'package:fe/data/model/users_model.dart';
import 'package:fe/data/repository/repositories.dart';
// import 'package:fe/data/repository/user_repository.dart'; // Perubahan di sini
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository; // Menggunakan UserRepository

  LoginBloc(this._userRepository) : super(LoginInitial()) {
    on<LoadLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final user = await _userRepository.login(event.email, event.password); // Menggunakan fungsi login dari UserRepository
        emit(LoginLoadedState(user));
      } catch (e) {
        emit(LoginErrorState(e.toString())); // Mengirim pesan error yang diterima dari UserRepository
      }
    });
  }
}
