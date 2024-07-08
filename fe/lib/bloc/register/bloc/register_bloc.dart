import 'package:bloc/bloc.dart';
import 'package:fe/bloc/register/bloc/register_event.dart';
import 'package:fe/bloc/register/bloc/register_state.dart';
import 'package:fe/data/model/users_model.dart'; // Import UserModel
import 'package:fe/data/repository/repositories.dart';
// import 'package:fe/data/repository/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({required this.userRepository}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is LoadRegisterEvent) {
      yield RegisterLoadingState();
      try {
        final user = await userRepository.register(
          event.fullName,
          event.email,
          event.password,
        );
        yield RegisterSuccessState(user); // Memicu RegisterSuccessState dengan user yang didaftarkan
      } catch (error) {
        yield RegisterErrorState(error.toString());
      }
    }
  }
}
