import 'dart:convert';

import 'package:anime_app/feature/anime_list/service/IAnimeListService.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';

import '../../../core/init/app_state/app_state.dart';
import '../../../core/utility/api_response.dart';
import '../model/anime_list_response_model.dart';


class AnimeListService extends IAnimeListService {
  AnimeListService(super.client);
  static const MethodChannel _channel = MethodChannel('animeListChannel');
  @override
  Future<List<AnimeListResponseModel>?> getAnimeList() async{
    try {
      final response = await _channel.invokeMethod('fetchAnimeList');
      Map<String, dynamic> jsonData = json.decode(response);
      List<dynamic> dataList= jsonData['data'];
      final result = ResponseParser<AnimeListResponseModel>(response: dataList).fromList<List<AnimeListResponseModel>>(model: AnimeListResponseModel());
      AppStateManager.instance.animeList = result ?? [];
      return result;
    } on DioError catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e,stackTrace,fatal: false, printDetails: true);
      throw DioException.connectionError( requestOptions: e.requestOptions, reason: e.message!);
    }
  }
}