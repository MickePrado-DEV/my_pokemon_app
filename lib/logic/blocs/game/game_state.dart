import 'package:equatable/equatable.dart';

abstract class GameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final List<String> games;
  final String selectedGame;

  GameLoaded({required this.games, required this.selectedGame});

  @override
  List<Object?> get props => [games, selectedGame];
}

class GameError extends GameState {
  final String message;
  GameError(this.message);

  @override
  List<Object?> get props => [message];
}