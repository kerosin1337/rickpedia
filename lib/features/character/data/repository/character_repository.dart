import '/core/api/dio_client.dart';
import '../models/character_model.dart';

class CharacterRepository {
  final DioClient _dioClient;

  CharacterRepository(this._dioClient);

  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await _dioClient.dio.get('/character');
      return (response.data['results'] as List)
          .map((map) => CharacterModel.fromMap(map))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
