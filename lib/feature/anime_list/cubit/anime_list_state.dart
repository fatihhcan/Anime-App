part of 'anime_list_cubit.dart';

class AnimeListState extends Equatable {

  final List<AnimeListResponseModel>? animeList;
  final bool isLoading;
  final int currentPage;
  final int itemsPerPage;
  const AnimeListState({
    this.animeList,
    this.isLoading = false,
    this.currentPage = 0,
    this.itemsPerPage = 20
  });

  @override
  List<Object?> get props => [animeList, isLoading, currentPage, itemsPerPage];

  AnimeListState copyWith({
    List<AnimeListResponseModel>? animeList,
    bool? isLoading,
    int? currentPage,
    int? itemsPerPage,
  }) {
    return AnimeListState(
      animeList: animeList ?? this.animeList,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage
    );
  }
}
