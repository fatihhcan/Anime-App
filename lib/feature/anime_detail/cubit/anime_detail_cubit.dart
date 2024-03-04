import 'package:anime_app/feature/anime_detail/service/anime_detail_list_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/base/cubit/base_cubit.dart';
import '../model/anime_detail_response_model.dart';

part 'anime_detail_state.dart';

class AnimeDetailCubit extends Cubit<AnimeDetailState> with BaseCubit {
  AnimeDetailCubit() : super(const AnimeDetailState());
  late AnimeDetailListService animeDetailListService;
  List<AnimeDetailResponseModel> animeDetailList = [];
  @override
  void init() async {
    initServices();

  }
  void initServices() async {
    animeDetailListService = AnimeDetailListService(dioManager.AnimeClient);
  }
  @override
  void setContext(BuildContext context) {}

  void getAnimeDetailLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }
  
  void fetchAnimeDetailList(int id) async {
    getAnimeDetailLoading(true);
    animeDetailList = (await animeDetailListService.getAnimeDetailList(id))!;
    emit(state.copyWith(animeDetailList: animeDetailList));
    getAnimeDetailLoading(false);
  }
  void navigate() async {
    await navigation.pop();
  }
}
