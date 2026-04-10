import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../../data/models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState(user: UserProfile.empty())) {
    on<SaveUserEvent>((event, emit) {
      final newUser = UserProfile(name: event.name, gender: event.gender);
      emit(UserState(user: newUser, isRegistered: true));
    });
  }
}