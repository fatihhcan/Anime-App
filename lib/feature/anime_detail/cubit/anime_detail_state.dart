part of 'anime_detail_cubit.dart';

class AnimeDetailState extends Equatable {

  final bool isLoading;
  final List<AnimeDetailResponseModel>? animeDetailList;
  const AnimeDetailState({
    this.isLoading = false,
    this.animeDetailList
  });

  @override
  List<Object?> get props => [ isLoading, animeDetailList];

  AnimeDetailState copyWith({
    bool? isLoading,
    List<AnimeDetailResponseModel>? animeDetailList
  }) {
    return AnimeDetailState(
      isLoading: isLoading ?? this.isLoading,
      animeDetailList: animeDetailList ?? this.animeDetailList
    );
  }
}
