import 'package:anime_app/core/constants/strings/strings_constant.dart';
import 'package:anime_app/feature/anime_list/cubit/anime_list_cubit.dart';
import 'package:anime_app/feature/anime_list/view/anime_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AnimeListView Test', (WidgetTester tester) async {
    final AnimeListCubit animeListCubit = AnimeListCubit();
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: animeListCubit,
          child: const AnimeListView(),
        ),
      ),
    );

    expect(find.text(StringConstants.animeAppText), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);

    await tester.tap(find.text(StringConstants.nextPageText));
    await tester.pump();

    expect(find.byType(ListTile), findsWidgets);

    await tester.tap(find.text(StringConstants.previousPageText));
    await tester.pump();

    expect(find.byType(ListTile), findsWidgets);
  });
}
