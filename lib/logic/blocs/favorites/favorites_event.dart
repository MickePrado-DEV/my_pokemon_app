import '../../../data/models/pokemon_model.dart';

abstract class FavoritesEvent {}

// Este es el que te faltaba: se dispara cuando la app abre para leer el disco
class LoadFavoritesEvent extends FavoritesEvent {}

// Este es el que ya tenías para agregar/quitar de la lista
class ToggleFavoriteEvent extends FavoritesEvent {
  final Pokemon pokemon;
  ToggleFavoriteEvent(this.pokemon);
}