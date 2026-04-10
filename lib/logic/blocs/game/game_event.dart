import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Para cargar la lista inicial de la PokeAPI
class LoadGamesEvent extends GameEvent {}

// Para cambiar el juego actual desde el Drawer
class SelectGameEvent extends GameEvent {
  final String gameName;
  SelectGameEvent(this.gameName);

  @override
  List<Object?> get props => [gameName];
}