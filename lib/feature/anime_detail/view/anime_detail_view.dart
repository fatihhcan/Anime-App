import 'package:anime_app/core/constants/app/app_constants.dart';
import 'package:anime_app/core/constants/strings/strings_constant.dart';
import 'package:anime_app/core/extensions/context_extensions.dart';
import 'package:anime_app/core/init/di/locator.dart';
import 'package:anime_app/feature/anime_list/cubit/anime_list_cubit.dart';
import 'package:anime_app/feature/anime_list/model/anime_list_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/base/view/base_view.dart';
import '../cubit/anime_detail_cubit.dart';

class AnimeDetailView extends StatelessWidget {
  final AnimeListResponseModel detail;
  const AnimeDetailView({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AnimeDetailCubit>(
      cubit: AnimeDetailCubit(),
      onCubitReady: (cubit) {
        cubit.setContext(context);
        cubit.init();
        cubit.fetchAnimeDetailList(detail.malId ?? 0);
      },
      onPageBuilder: (AnimeDetailCubit cubit) => Scaffold(
        appBar: buildAppBar(context, cubit),
        body: buildBody(cubit),
      ),
    );
  }

  BlocBuilder<AnimeDetailCubit, AnimeDetailState> buildBody(
      AnimeDetailCubit cubit) {
    return BlocBuilder<AnimeDetailCubit, AnimeDetailState>(
      builder: (context, state) {
        return state.isLoading
            ?  Center(child: CircularProgressIndicator(color: context.appColors.trinidad))
            : ListView(
                children: [
                  Padding(
                    padding: context.paddingLowHorizontal,
                    child: Column(
                      children: [
                        Image.network(detail.images!.jpg!.imageUrl ?? ''),
                        Text(
                          detail.title ?? '',
                          style: context.textTheme.headlineMedium,
                        ),
                        Text(
                            '${StringConstants.raitinScoreText} ${detail.score ?? ''}'),
                        Text(
                            '${StringConstants.episodesText} ${detail.episodes ?? ''}'),
                        Text(
                            'Example DI: ${locator<AnimeListCubit>().exampleDI() ?? ''}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: context.paddingLowAll,
                    child: SizedBox(
                      height: context.highValue * 1.5,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            context.sizedBoxLowHorizontal,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.animeDetailList!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  state.animeDetailList?[index].character
                                          ?.images?.jpg?.imageUrl ??
                                      AppConstants.EMPTY_IMAGES_URL,
                                  height: context.highValue * 1.4,
                                ),
                              ),
                              Text(state.animeDetailList?[index].character
                                      ?.name ??
                                  ''),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: context.paddingLowAll,
                    child: Text(
                        '${StringConstants.synopsisText} \n${detail.synopsis ?? ''}'),
                  ),
                ],
              );
      },
    );
  }

  AppBar buildAppBar(BuildContext context, AnimeDetailCubit cubit) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      iconTheme: IconThemeData(color: context.appColors.mirage),
      title: const Text(
        StringConstants.animeDetailText,
      ),
      centerTitle: false,
      leading: IconButton(
          onPressed: () => cubit.navigate(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.appColors.white,
          )),
    );
  }
}
