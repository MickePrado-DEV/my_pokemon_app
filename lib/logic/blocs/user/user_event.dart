

import 'package:my_pokemon_app/data/models/user_model.dart';

abstract class UserEvent {}

class SaveUserEvent extends UserEvent {
  final String name;
  final Gender gender;
  SaveUserEvent(this.name, this.gender);
}

class LoadUserEvent extends UserEvent {}