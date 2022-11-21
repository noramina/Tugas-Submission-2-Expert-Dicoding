import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/genre_tv.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/y5Z0WesTjvn59jP6yo459eUsbli.jpg',
  genreIds: [27, 53],
  id: 663712,
  originalTitle: 'Terrifier 2',
  overview:
      'After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt down and destroy a teenage girl and her younger brother on Halloween night.  As the body count rises, the siblings fight to stay alive while uncovering the true nature of Arts evil intent.',
  popularity: 7866.782,
  posterPath: '/b6IRp6Pl2Fsq37r9jFhGoLtaqHm.jpg',
  releaseDate: '2022-10-06',
  title: 'Terrifier 2',
  video: false,
  voteAverage: 7.1,
  voteCount: 445,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};


final testTv = Tv(
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

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  genres: [Genretv(id: 1, name: 'Action')],
  seasons: [
    Season(id: 1, name: 'Season 1', episodeCount: 1, posterPath: 'posterPath'),
  ],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: null,
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: null,
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
