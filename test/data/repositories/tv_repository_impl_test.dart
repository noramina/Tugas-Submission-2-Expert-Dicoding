import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_genre_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvModel = TvModel(
  backdropPath: '/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg',
  genreIds: [18, 80],
  id: 31586,
  originalName: 'La Reina del Sur',
  overview:
      'After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means..',
  popularity: 1920.372,
  posterPath: '/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg',
  firstAirDate: '2011-02-28',
  name: 'Miraculous: Tales of Ladybug & Cat Noir',
  voteAverage: 7.8,
  voteCount: 1350,
  );

  final tTv = Tv(
  backdropPath: '/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg',
  genreIds: [18, 80],
  id: 31586,
  originalName: 'La Reina del Sur',
  overview:
      'After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means..',
  popularity: 1920.372,
  posterPath: '/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg',
  firstAirDate: '2011-02-28',
  name: 'Miraculous: Tales of Ladybug & Cat Noir',
  voteAverage: 7.8,
  voteCount: 1350,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Now Playing TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAiringTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getOnAirTv();
      // assert
      verify(mockRemoteDataSource.getOnAiringTv());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAiringTv()).thenThrow(ServerException());
      // act
      final result = await repository.getOnAirTv();
      // assert
      verify(mockRemoteDataSource.getOnAiringTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAiringTv())
          .thenThrow(SocketException('Gagal terhubung ke jaringan'));
      // act
      final result = await repository.getOnAirTv();
      // assert
      verify(mockRemoteDataSource.getOnAiringTv());
      expect(result,
          equals(Left(ConnectionFailure('Gagal terhubung ke jaringan'))));
    });
  });

  group('Popular TV Series', () {
    test('should return TV Serieslist when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTv();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenThrow(SocketException('Gagal terhubung ke jaringan'));
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Gagal terhubung ke jaringan')));
    });
  });

  group('Top Rated TV Series', () {
    test('should return TV Serieslist when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTv();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {

      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenThrow(SocketException('Gagal terhubung ke jaringan'));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Gagal terhubung ke jaringan')));
    });
  });

  group('Get TV Series Detail', () {
    final tId = 1;
    final tTvResponse = TvDetailRespon(
      backdropPath: 'backdropPath',
      genres: [TvGenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      status: 'Status',
      tagline: 'Tagline',
      name: 'name',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      voteAverage: 1,
      voteCount: 1,
      seasons: [
        SeasonModel(
          id: 1,
          name: 'Season 1',
          episodeCount: 1,
          posterPath: 'posterPath',
        )
      ],
    );

    test(
        'should return TV Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenThrow(SocketException('Gagal terhubung ke jaringan'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Gagal terhubung ke jaringan'))));
    });
  });

  group('Get TV Series Recommendations', () {
    final tTvList = <TvModel>[];
    final tId = 1;

    test('should return data (TV Serieslist) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Gagal terhubung ke jaringan'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Gagal terhubung ke jaringan'))));
    });
  });

  group('Seach TV Series', () {
    final tQuery = 'spiderman';

    test('should return TV Serieslist when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenThrow(SocketException('Gagal terhubung ke jaringan'));
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Gagal terhubung ke jaringan')));
    });
  });

  // group('save watchlist', () {
  //   test('should return success message when saving successful', () async {
  //     // arrange
  //     when(mockLocalDataSource.insertWatchlist(testTvTable))
  //         .thenAnswer((_) async => 'Added to Watchlist');
  //     // act
  //     final result = await repository.saveWatchlist(testTvDetail);
  //     // assert
  //     expect(result, Right('Added to Watchlist'));
  //   });

  //   test('should return DatabaseFailure when saving unsuccessful', () async {
  //     // arrange
  //     when(mockLocalDataSource.insertWatchlist(testTvTable))
  //         .thenThrow(DatabaseException('Failed to add watchlist'));
  //     // act
  //     final result = await repository.saveWatchlist(testTvDetail);
  //     // assert
  //     expect(result, Left(DatabaseFailure('Failed to add watchlist')));
  //   });
  // });

  // group('remove watchlist', () {
  //   test('should return success message when remove successful', () async {
  //     // arrange
  //     when(mockLocalDataSource.removeWatchlist(testTvTable))
  //         .thenAnswer((_) async => 'Removed from watchlist');
  //     // act
  //     final result = await repository.removeWatchlist(testTvDetail);
  //     // assert
  //     expect(result, Right('Removed from watchlist'));
  //   });

  //   test('should return DatabaseFailure when remove unsuccessful', () async {
  //     // arrange
  //     when(mockLocalDataSource.removeWatchlist(testTvTable))
  //         .thenThrow(DatabaseException('Failed to remove watchlist'));
  //     // act
  //     final result = await repository.removeWatchlist(testTvDetail);
  //     // assert
  //     expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
  //   });
  // });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TV Series', () {
    test('should return list of TV Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
