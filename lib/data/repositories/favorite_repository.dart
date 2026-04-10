import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pokemon_model.dart';

class FavoriteRepository {
  static const String _key = 'favorite_pokemons';

  // Guardar la lista completa de favoritos
  Future<void> saveFavorites(List<Pokemon> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    // Convertimos la lista de objetos Pokemon a una lista de Mapas JSON
    final String encodedData = json.encode(
      favorites.map((p) => {
        'id': p.id,
        'name': p.name,
        'url': 'https://pokeapi.co/api/v2/pokemon/${p.id}/' // Reconstruimos la URL base
      }).toList(),
    );
    await prefs.setString(_key, encodedData);
  }

  // Cargar los favoritos guardados
  Future<List<Pokemon>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString(_key);

    if (savedData == null) return [];

    final List decodedData = json.decode(savedData);
    return decodedData.map((item) => Pokemon.fromJson(item)).toList();
  }
}