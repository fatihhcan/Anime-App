import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../../../core/init/app_state/app_state.dart';
import '../../../core/utility/api_response.dart';
import '../model/anime_detail_response_model.dart';
import 'IAnimeDetailListService.dart';

class AnimeDetailListService extends IAnimeDetailListService {
  AnimeDetailListService(super.client);

  @override
  Future<List<AnimeDetailResponseModel>?> getAnimeDetailList(int id) async {
    try {
      final response = await client.get('anime/$id/characters');
      final result = ResponseParser<AnimeDetailResponseModel>(response: response['data'])
          .fromList<List<AnimeDetailResponseModel>>(model: AnimeDetailResponseModel());
      AppStateManager.instance.animeDetailList = result ?? [];
      return result;
    } on DioError catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e,stackTrace,fatal: false, printDetails: true);
      throw DioException.connectionError( requestOptions: e.requestOptions, reason: e.message!);
    }
  }
}
