import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/more_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/now_playing_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/now_playing_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/search_page_tv.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:ditonton/ssl_pinning.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await SslPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAnalytics.instance.logAppOpen();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistBloc>(),
        ),

        BlocProvider(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>()
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchPageTv.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageTv());
            case NowPlayingTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingTvPage());
              case NowPlayingMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingMoviePage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
              case MorePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => MorePage());
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
