import 'package:my_pokemon_app/data/models/pokemon_model.dart';

abstract class PokemonState {}
class PokemonInitial extends PokemonState {}
class PokemonLoading extends PokemonState {}
class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  PokemonLoaded(this.pokemons);
}
class PokemonError extends PokemonState { final String message; PokemonError(this.message); }