import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pokemon_app/data/models/pokemon_model.dart';
import 'team_event.dart';
import 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  TeamBloc() : super(TeamState(myTeam: [])) {
    
    on<AddToTeamEvent>((event, emit) {
      if (state.myTeam.length < 6) {
        if (!state.myTeam.any((p) => p.id == event.pokemon.id)) {
          final newTeam = List<Pokemon>.from(state.myTeam)..add(event.pokemon);
          emit(TeamState(myTeam: newTeam));
        }
      } else {
        // Si ya hay 6, emitimos un error temporal
        emit(TeamState(myTeam: state.myTeam, errorMessage: "¡Tu equipo ya está lleno! (Máximo 6)"));
      }
    });

    on<RemoveFromTeamEvent>((event, emit) {
      final newTeam = state.myTeam.where((p) => p.id != event.pokemonId).toList();
      emit(TeamState(myTeam: newTeam));
    });
  }
}