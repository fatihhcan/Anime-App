
import 'package:anime_app/core/utility/arguments.dart';
import 'package:anime_app/feature/anime_detail/view/anime_detail_view.dart';
import 'package:flutter/material.dart';
import '../../../feature/anime_list/view/anime_list_view.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.DEFAULT:
        return normalNavigate(const AnimeListView());
      case NavigationConstants.ANIME_DETAIL:
      final AnimeDetailArguments argsAnimeDetail =
            args.arguments as AnimeDetailArguments;
               return MaterialPageRoute(
            builder: (_) => AnimeDetailView(detail: argsAnimeDetail.detail));
      default:
        return normalNavigate(const NotFoundNavigation());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class NotFoundNavigation extends StatefulWidget {
  const NotFoundNavigation({Key? key}) : super(key: key);

  @override
  _NotFoundNavigationState createState() => _NotFoundNavigationState();
}

class _NotFoundNavigationState extends State<NotFoundNavigation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Navigation not found'),
    );
  }
}
