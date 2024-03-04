import 'package:anime_app/feature/anime_detail/cubit/anime_detail_cubit.dart';
import 'package:anime_app/feature/anime_list/cubit/anime_list_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton(() => AnimeListCubit());
  locator.registerLazySingleton(() => AnimeDetailCubit());
}
