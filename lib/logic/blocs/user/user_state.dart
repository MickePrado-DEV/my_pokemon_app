import '../../../data/models/user_model.dart';

class UserState {
  final UserProfile user;
  final bool isRegistered;

  UserState({required this.user, this.isRegistered = false});
}