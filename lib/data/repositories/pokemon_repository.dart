import '../../core/network/dio_client.dart';
import '../models/pokemon_model.dart';

class PokemonRepository {
  final DioClient _dioClient;

  PokemonRepository(this._dioClient);

  Future<List<Pokemon>> getPokemonsByGame(String gameName) async {
    try {
      // 1. Obtenemos información del grupo de versiones (juego)
      final gameResponse = await _dioClient.dio.get('version-group/$gameName');
      
      // 2. Buscamos la Pokedex de ese juego (usamos la primera disponible)
      final pokedexUrl = gameResponse.data['pokedexes'][0]['url'];
      
      // 3. Consultamos esa Pokedex
      final pokedexResponse = await _dioClient.dio.get(pokedexUrl);
      final List entries = pokedexResponse.data['pokemon_entries'];

      // 4. Mapeamos los primeros 20 (o los que quieras)
      return entries
          .take(20) 
          .map((e) => Pokemon.fromJson(e['pokemon_species']))
          .toList();
    } catch (e) {
      throw Exception('Error al cargar pokemons: $e');
    }
  }
}