import '../../../core/init/network/dio_client.dart';
import '../model/anime_detail_response_model.dart';

abstract class IAnimeDetailListService {
  final DioClient client;

  IAnimeDetailListService(this.client);

  Future<List<AnimeDetailResponseModel>?> getAnimeDetailList(int id);
}