import '/core/api/dio_client.dart';
import '/core/api/models/response.dart';
import '/features/character/data/models/character_model.dart';

class CharacterRepository {
  final DioClient _dioClient;

  CharacterRepository(this._dioClient);

  Future<DioResponse<CharacterModel>> getCharacters(int page) async {
    try {
      final response = await _dioClient.dio.get(
        '/character',
        queryParameters: {'page': page},
      );
      return DioResponse(
        items: (response.data['results'] as List)
            .map((map) => CharacterModel.fromMap(map))
            .toList(),
        hasReachedMax: response.data['info']['next'] == null,
      );
    } catch (e) {
      rethrow;
    }
  }
}
