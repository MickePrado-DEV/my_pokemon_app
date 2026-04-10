import 'package:flutter_bloc/flutter_bloc.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';
import '../../../data/repositories/pokemon_repository.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository repository;

  PokemonBloc(this.repository) : super(PokemonInitial()) {
    on<FetchPokemonsEvent>((event, emit) async {
      emit(PokemonLoading());
      try {
        final pokemons = await repository.getPokemonsByGame(event.gameName);
        emit(PokemonLoaded(pokemons));
      } catch (e) {
        emit(PokemonError(e.toString()));
      }
    });
  }
}