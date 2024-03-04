import 'package:anime_app/core/init/network/dio_manager.dart';
import 'package:anime_app/feature/anime_detail/model/anime_detail_response_model.dart';
import 'package:anime_app/feature/anime_detail/service/anime_detail_list_service.dart';
import 'package:anime_app/feature/anime_list/model/anime_list_response_model.dart';
import 'package:anime_app/feature/anime_list/service/anime_list_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late AnimeListService animeListService;
  late AnimeDetailListService animeDetailListService;
  DioManager dioManager = DioManager.instance;
  List<AnimeListResponseModel> animeList = [];
  List<AnimeDetailResponseModel> animeDetailList = [];

  const MethodChannel channel = MethodChannel('animeListChannel');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'fetchAnimeList') {
      return '{"data": []}';
    }
    return null;
  });

  setUp(() async {
    animeListService = AnimeListService(dioManager.AnimeClient);
    animeDetailListService = AnimeDetailListService(dioManager.AnimeClient);
  });

  group('Call API', () {
    test('Fetch AnimeList', () async {
      animeList = (await animeListService.getAnimeList())!;
      expect(animeList, isNotNull);
      expect(animeList, isA<List<AnimeListResponseModel>>());
    });

    test('Fetch AnimeDetailList', () async {
      animeDetailList = (await animeDetailListService.getAnimeDetailList(52991))!;
      expect(animeDetailList, isNotNull);
      expect(animeDetailList, isA<List<AnimeDetailResponseModel>>());
    });
  });
}
