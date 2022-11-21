import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv_bloc.dart';


void main() {
  late TvDetailBlocHelper tvDetailBlocHelper;
  late TvRecommendationBlocHelper recommendationsTvBlocHelper;
  late WatchlistTvBloc watchlistTvBlocHelper;

  setUpAll(() {
    tvDetailBlocHelper = TvDetailBlocHelper();
    registerFallbackValue(TvDetailEventHelper());
    registerFallbackValue(TvDetailStateHelper());

    recommendationsTvBlocHelper = TvRecommendationBlocHelper();
    registerFallbackValue(TvRecommendationEventBlocHelper());
    registerFallbackValue(TvRecommendationStateHelper());

    watchlistTvBlocHelper = WatchlistTvBlocHelper();
    registerFallbackValue(WatchlistTvBlocHelper());
    registerFallbackValue(WatchlistTvStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(create: (_) => tvDetailBlocHelper),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => watchlistTvBlocHelper,
        ),
        BlocProvider<TvRecommendationBloc>(
          create: (_) => recommendationsTvBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => tvDetailBlocHelper.state).thenReturn(TvLoading());
        when(() => watchlistTvBlocHelper.state).thenReturn(TvLoading());
        when(() => recommendationsTvBlocHelper.state).thenReturn(TvLoading());

        final circularProgress = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
          id: 1,
        )));
        await tester.pump();

        expect(circularProgress, findsOneWidget);
      });
  testWidgets(
      'Watchlist button should display + icon when movie not added to watch list',
          (WidgetTester tester) async {
        when(() => tvDetailBlocHelper.state)
            .thenReturn(TvDetailState(testTvDetail));
        when(() => recommendationsTvBlocHelper.state)
            .thenReturn(TvHasData(testTvList));
        when(() => watchlistTvBlocHelper.state)
            .thenReturn(WatchlistTvStatusState(false));

        final watchListButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget( TvDetailPage(id: 97080)));
        await tester.pump();
        expect(watchListButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when movie added to watch list',
          (WidgetTester tester) async {
        when(() => tvDetailBlocHelper.state)
            .thenReturn(TvDetailState(testTvDetail));

        when(() => recommendationsTvBlocHelper.state)
            .thenReturn(TvHasData(testTvList));
        when(() => watchlistTvBlocHelper.state)
            .thenReturn(WatchlistTvStatusState(true));

        final watchListButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget( TvDetailPage(id: 97080)));
        expect(watchListButtonIcon, findsOneWidget);
      });
}
