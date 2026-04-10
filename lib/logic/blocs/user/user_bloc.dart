import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserState(user: UserProfile.empty())) {
    
    // Cargar del disco al iniciar
    on<LoadUserEvent>((event, emit) async {
      final profile = await userRepository.getUser();
      if (profile != null) {
        emit(UserState(user: profile, isRegistered: true));
      }
    });

    // Guardar en el disco y emitir estado
    on<SaveUserEvent>((event, emit) async {
      await userRepository.saveUser(event.name, event.gender);
      final newUser = UserProfile(name: event.name, gender: event.gender);
      emit(UserState(user: newUser, isRegistered: true));
    });
  }
}