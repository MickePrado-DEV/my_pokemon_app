import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pokemon_app/data/repositories/favorite_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

import '../../../data/models/pokemon_model.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteRepository repository;

  FavoritesBloc(this.repository) : super(FavoritesState(favoritePokemons: [])) {
    
    // Evento para cargar favoritos al iniciar la app
    on<LoadFavoritesEvent>((event, emit) async {
      final favorites = await repository.loadFavorites();
      emit(FavoritesState(favoritePokemons: favorites));
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      final currentFavorites = List<Pokemon>.from(state.favoritePokemons);
      
      if (currentFavorites.any((p) => p.id == event.pokemon.id)) {
        currentFavorites.removeWhere((p) => p.id == event.pokemon.id);
      } else {
        currentFavorites.add(event.pokemon);
      }
      
      // Guardamos en persistencia
      await repository.saveFavorites(currentFavorites);
      emit(FavoritesState(favoritePokemons: currentFavorites));
    });
  }
}