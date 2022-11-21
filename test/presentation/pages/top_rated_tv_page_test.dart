import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv_bloc.dart';


void main() {
  late TopRatedTvBlocHelper topRatedTvBlocHelper;

  setUpAll(() {
    topRatedTvBlocHelper = TopRatedTvBlocHelper();
    registerFallbackValue(TopRatedTvBlocHelper());
    registerFallbackValue(TopRatedTvStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (_) => topRatedTvBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => topRatedTvBlocHelper.state).thenReturn(TvLoading());

        final progressFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => topRatedTvBlocHelper.state)
            .thenAnswer((invocation) => TvLoading());
        when(() => topRatedTvBlocHelper.state).thenReturn(TvHasData(testTvList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

        expect(listViewFinder, findsOneWidget);
      });

}
