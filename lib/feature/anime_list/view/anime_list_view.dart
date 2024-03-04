import 'package:anime_app/core/constants/app/app_constants.dart';
import 'package:anime_app/core/constants/strings/strings_constant.dart';
import 'package:anime_app/core/extensions/context_extensions.dart';
import 'package:anime_app/core/utility/arguments.dart';
import 'package:anime_app/feature/anime_list/cubit/anime_list_cubit.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/constants/navigation/navigation_constants.dart';

class AnimeListView extends StatelessWidget {
  const AnimeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AnimeListCubit>(
      cubit: AnimeListCubit(),
      onCubitReady: (cubit) {
        cubit.setContext(context);
        cubit.init();
      },
      onPageBuilder: (AnimeListCubit cubit) => Scaffold(
        appBar: buildAppBar(context),
        body: buildBody(cubit),
      ),
    );
  }

  BlocBuilder<AnimeListCubit, AnimeListState> buildBody(AnimeListCubit cubit) {
    return BlocBuilder<AnimeListCubit, AnimeListState>(
      builder: (context, state) {
        return state.isLoading
            ?  Center(child: CircularProgressIndicator(color: context.appColors.trinidad,))
            : Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: context.paddingLowHorizontal,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          final realIndex =
                              (state.currentPage * state.itemsPerPage) + index;
                          return ListTile(
                            title: Text(state.animeList?[index].title ?? ''),
                            leading: SizedBox(
                              width: context.highValue * 1.2,
                              child: Row(
                                children: [
                                  Text('${realIndex + 1}'),
                                  context.sizedBoxMediumHorizontal,
                                  Image.network(state.animeList?[index].images
                                          ?.jpg?.imageUrl ??
                                      AppConstants.EMPTY_IMAGES_URL),
                                ],
                              ),
                            ),
                            subtitle: Text(
                                '${StringConstants.raitinScoreText} ${state.animeList?[index].score ?? ''}'),
                            trailing: IconButton(
                                onPressed: () => {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                )),
                            onTap: ()  {
                              //Test Firebase Crashlytics 
                             // FirebaseCrashlytics.instance.crash();
                              Navigator.of(context).pushNamed(
                                  NavigationConstants.ANIME_DETAIL,
                                  arguments: AnimeDetailArguments(
                                      detail: state.animeList![index]));
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            context.sizedBoxLowVertical,
                        itemCount: cubit.animeList
                            .skip(state.currentPage * state.itemsPerPage)
                            .take(state.itemsPerPage)
                            .toList()
                            .length,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: context.appColors.white,
                            backgroundColor: context.appColors.trinidad,
                          ),
                          onPressed: () => cubit.previousPage(),
                          child: const Text(StringConstants.previousPageText)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: context.appColors.white,
                            backgroundColor: context.appColors.trinidad,
                          ),
                          onPressed: () => cubit.nextPage(),
                          child: const Text(StringConstants.nextPageText)),
                    ],
                  )
                ],
              );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: context.appColors.mirage),
      title: const Text(
        StringConstants.animeAppText,
      ),
      centerTitle: false,
    );
  }
}
