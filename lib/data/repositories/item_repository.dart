import '../../core/network/dio_client.dart';
import '../models/item_model.dart';

class ItemRepository {
  final DioClient _dioClient;
  ItemRepository(this._dioClient);

  Future<List<ItemModel>> getItems() async {
    try {
      // Traemos los primeros 50 objetos comunes
      final response = await _dioClient.dio.get('item?limit=50');
      final List results = response.data['results'];
      return results.map((item) => ItemModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Error al cargar objetos: $e');
    }
  }
}