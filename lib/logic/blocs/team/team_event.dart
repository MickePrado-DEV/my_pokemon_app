import '../../../data/models/pokemon_model.dart';

abstract class TeamEvent {}

class AddToTeamEvent extends TeamEvent {
  final Pokemon pokemon;
  AddToTeamEvent(this.pokemon);
}

class RemoveFromTeamEvent extends TeamEvent {
  final int pokemonId;
  RemoveFromTeamEvent(this.pokemonId);
}