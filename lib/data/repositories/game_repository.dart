

import 'package:my_pokemon_app/core/network/dio_client.dart';

class GameRepository {
  final DioClient _dioClient;

  GameRepository(this._dioClient);

  Future<List<String>> getGameVersions() async {
    try {
      // Usamos .dio porque así nombraste a tu getter
      final response = await _dioClient.dio.get('version-group?limit=20');
      final List results = response.data['results'];
      return results.map((game) => game['name'] as String).toList();
    } catch (e) {
      throw Exception('Error al cargar juegos: $e');
    }
  }
}