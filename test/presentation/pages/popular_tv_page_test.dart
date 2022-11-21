
import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv_bloc.dart';

void main() {
  late PopularTvBlocHelper popularTvBlocHelper;
  setUpAll(() {
    popularTvBlocHelper = PopularTvBlocHelper();
    registerFallbackValue(PopularTvStateHelper());
    registerFallbackValue(PopularTvEventBlocHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => popularTvBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularTvBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state).thenReturn(TvLoading());
    when(() => popularTvBlocHelper.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  
}
