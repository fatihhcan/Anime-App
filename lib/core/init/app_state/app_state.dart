import 'package:anime_app/feature/anime_list/model/anime_list_response_model.dart';
import '../../../feature/anime_detail/model/anime_detail_response_model.dart';

class AppStateManager {
  static AppStateManager? _instance;
  static AppStateManager get instance {
    return _instance ??= AppStateManager.init();
  }
  List<AnimeListResponseModel> animeList = [];
  List<AnimeDetailResponseModel> animeDetailList = [];
  AppStateManager.init();
}
