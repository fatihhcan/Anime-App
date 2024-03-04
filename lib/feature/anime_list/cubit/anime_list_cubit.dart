import 'package:anime_app/feature/anime_list/service/anime_list_service.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';

import '../../../core/base/cubit/base_cubit.dart';
import '../model/anime_list_response_model.dart';

part 'anime_list_state.dart';

class AnimeListCubit extends Cubit<AnimeListState> with BaseCubit {
  AnimeListCubit() : super(const AnimeListState());
  late AnimeListService animeListService;
  List<AnimeListResponseModel> animeList = [];
  @override
  void init() async {
    initServices();
    fetchAnimeList();
    loadItems();

  }
  void initServices() async {
    animeListService = AnimeListService(dioManager.AnimeClient);
  }
  @override
  void setContext(BuildContext context) {}

  void getAnimeLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }

  void fetchAnimeList() async {
    getAnimeLoading(true);
    animeList = (await animeListService.getAnimeList())!;

    emit(state.copyWith(animeList: animeList));
    getAnimeLoading(false);
  }

  void loadItems() {
    emit(state.copyWith(animeList: animeList
        .skip(state.currentPage * state.itemsPerPage)
        .take(state.itemsPerPage)
        .toList()));
  }

  void nextPage() {
    if ((state.currentPage + 1) * state.itemsPerPage <= state.animeList!.length) {
     emit(state.copyWith(currentPage: state.currentPage + 1));
      loadItems();
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
     emit(state.copyWith(currentPage: state.currentPage - 1));
      loadItems();
    }
  }

  String exampleDI() {
    return 'Example DI';
  }
}
