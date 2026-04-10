import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';
import '../../../data/repositories/game_repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;

  GameBloc(this.gameRepository) : super(GameInitial()) {
    
    // Lógica para cargar juegos
    on<LoadGamesEvent>((event, emit) async {
      emit(GameLoading());
      try {
        final games = await gameRepository.getGameVersions();
        if (games.isNotEmpty) {
          emit(GameLoaded(games: games, selectedGame: games.first));
        } else {
          emit(GameError("No se encontraron juegos"));
        }
      } catch (e) {
        emit(GameError(e.toString()));
      }
    });

    // Lógica para seleccionar un juego
    on<SelectGameEvent>((event, emit) {
      if (state is GameLoaded) {
        final currentState = state as GameLoaded;
        emit(GameLoaded(
          games: currentState.games, 
          selectedGame: event.gameName
        ));
      }
    });
  }
}