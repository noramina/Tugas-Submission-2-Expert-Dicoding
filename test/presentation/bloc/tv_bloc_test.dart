import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_bloc_test.mocks.dart';




@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetOnAiringTv,
  GetTopRatedTv,
  GetPopularTv,
  GetWatchlistTv,
  GetTvWatchListStatusTv,
  RemoveTvWatchlist,
  SaveTvWatchlist,
])
void main() {
  late NowPlayingTvBloc onTheAirNowBloc;
  late PopularTvBloc popularTvBloc;
  late TopRatedTvBloc topRatedTvBloc;
  late TvDetailBloc detailTvBloc;
  late TvRecommendationBloc recommendationTvBloc;
  late WatchlistTvBloc watchlistTvBloc;

  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecomendation;
  late MockGetOnAiringTv mockGetOnTheAirTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetWatchlistTv mockGetWatchListTv;
  late MockGetTvWatchListStatusTv mockGetWatchListTvStatus;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late MockSaveTvWatchlist mockSaveTvWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecomendation = MockGetTvRecommendations();
    mockGetOnTheAirTv = MockGetOnAiringTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetWatchListTv = MockGetWatchlistTv();
    mockGetWatchListTvStatus = MockGetTvWatchListStatusTv();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    mockSaveTvWatchlist = MockSaveTvWatchlist();

    onTheAirNowBloc = NowPlayingTvBloc(mockGetOnTheAirTv);
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);

    watchlistTvBloc = WatchlistTvBloc(
      mockGetWatchListTv,
      mockGetWatchListTvStatus,
      mockSaveTvWatchlist,
      mockRemoveTvWatchlist,
    );
    recommendationTvBloc = TvRecommendationBloc(mockGetTvRecomendation);
    detailTvBloc = TvDetailBloc(
      mockGetTvDetail,
    );
  });

  final tTv = Tv(
    backdropPath: '/backdropPath',
    firstAirDate: '2021-01-01',
    genreIds: const [1, 2],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];
  final tId = 1;

  group('Get now playing movies', () {
    test('initial state must be empty', () {
      expect(onTheAirNowBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return onTheAirNowBloc;
      },
      act: (NowPlayingTvBloc bloc) => bloc.add(FetchOnAiringTv()),
      wait: Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetOnTheAirTv.execute()).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return onTheAirNowBloc;
      },
      act: (NowPlayingTvBloc bloc) => bloc.add(FetchOnAiringTv()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        TvError('Server Failure'),
      ],
      verify: (NowPlayingTvBloc bloc) => verify(mockGetOnTheAirTv.execute()),
    );
  });

  group('Get Popular movies', () {
    test('initial state must be empty', () {
      expect(popularTvBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      act: (PopularTvBloc bloc) => bloc.add(FetchPopularTv()),
      wait: Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (PopularTvBloc bloc) => bloc.add(FetchPopularTv()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularTv.execute()),
    );
  });

  group('Get Top Rated movies', () {
    test('initial state must be empty', () {
      expect(topRatedTvBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedTvBloc;
      },
      act: (TopRatedTvBloc bloc) => bloc.add(FetchTopRatedTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (TopRatedTvBloc bloc) => bloc.add(FetchTopRatedTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTopRatedTv.execute()),
    );
  });

  group('Get Recommended movies', () {
    test('initial state must be empty', () {
      expect(recommendationTvBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvRecomendation.execute(tId))
            .thenAnswer((_) async => Right(tTvList));
        return recommendationTvBloc;
      },
      act: (TvRecommendationBloc bloc) => bloc.add(FetchTvRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvRecomendation.execute(tId)).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return recommendationTvBloc;
      },
      act: (TvRecommendationBloc bloc) => bloc.add(FetchTvRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvRecomendation.execute(tId)),
    );
  });

  group('Get Details movies', () {
    test('initial state must be empty', () {
      expect(detailTvBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        return detailTvBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(FetchDetailTv(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvDetailState(testTvDetail)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return detailTvBloc;
      },
      act: (TvDetailBloc bloc) => bloc.add(FetchDetailTv(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvDetail.execute(tId)),
    );
  });

  group('Get Watchlist movies', () {
    test('initial state must be empty', () {
      expect(watchlistTvBloc.state, TvEmpty());
    });

    group('Watchlist Movie', () {
      test('initial state should be empty', () {
        expect(watchlistTvBloc.state, TvEmpty());
      });

      group('Fetch Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchListTv.execute())
                .thenAnswer((_) async => Right(tTvList));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(FetchWatchlistTv()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            WatchlistTvState(tTvList),
          ],
          verify: (bloc) => verify(mockGetWatchListTv.execute()),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchListTv.execute())
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(FetchWatchlistTv()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const TvError('Server Failure'),
          ],
          verify: (bloc) => verify(mockGetWatchListTv.execute()),
        );
      });

      group('Load Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchListTvStatus.execute(tId))
                .thenAnswer((_) async => true);
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(WatchlistTvStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            WatchlistTvStatusState(true),
          ],
          verify: (bloc) => verify(mockGetWatchListTvStatus.execute(tId)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchListTvStatus.execute(tId))
                .thenAnswer((_) async => false);
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(WatchlistTvStatus(tId)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            WatchlistTvStatusState(false),
          ],
          verify: (bloc) => verify(mockGetWatchListTvStatus.execute(tId)),
        );
      });

      group('Save Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer(
                    (_) async => Right(WatchlistTvBloc.watchlistAddSuccessMessage));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(SaveWatchistTv(testTvDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            WatchlistTvMessage(WatchlistTvBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) => verify(mockSaveTvWatchlist.execute(testTvDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockSaveTvWatchlist.execute(testTvDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(SaveWatchistTv(testTvDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            TvError('Server Failure'),
          ],
          verify: (bloc) => verify(mockSaveTvWatchlist.execute(testTvDetail)),
        );
      });

      group('Remove Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockRemoveTvWatchlist.execute(testTvDetail)).thenAnswer(
                    (_) async => Right(WatchlistTvBloc.watchlistAddSuccessMessage));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(RemoveWatchlistTvEvent(testTvDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            WatchlistTvMessage(WatchlistTvBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) => verify(mockRemoveTvWatchlist.execute(testTvDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockRemoveTvWatchlist.execute(testTvDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(RemoveWatchlistTvEvent(testTvDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            TvError('Server Failure'),
          ],
          verify: (bloc) => verify(mockRemoveTvWatchlist.execute(testTvDetail)),
        );
      });

    });
  });
}
