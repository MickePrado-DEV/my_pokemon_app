abstract class PokemonEvent {}
class FetchPokemonsEvent extends PokemonEvent {
  final String gameName;
  FetchPokemonsEvent(this.gameName);
}