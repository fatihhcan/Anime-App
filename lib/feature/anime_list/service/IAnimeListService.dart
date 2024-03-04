import '../../../core/init/network/dio_client.dart';
import '../model/anime_list_response_model.dart';

abstract class IAnimeListService {
  final DioClient client;

  IAnimeListService(this.client);

  Future<List<AnimeListResponseModel>?> getAnimeList();
}