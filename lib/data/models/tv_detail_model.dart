import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/data/models/tv_genre_model.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models/season_model.dart';


class TvDetailRespon extends Equatable {
  TvDetailRespon({
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.status,
    required this.tagline,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,

  });

  final String? backdropPath;
  final List<TvGenreModel> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String firstAirDate;
  final String status;
  final String tagline;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final double voteAverage;
  final int voteCount;
  final List<SeasonModel> seasons;


  factory TvDetailRespon.fromJson(Map<String, dynamic> json) =>
      TvDetailRespon(
        backdropPath: json["backdrop_path"],
        genres: List<TvGenreModel>.from(
            json["genres"].map((x) => TvGenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        status: json["status"],
        tagline: json["tagline"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "status": status,
        "tagline": tagline,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      name: this.name,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,  
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      seasons: seasons.map((season) => season.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        homepage,
        id,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        status,
        tagline,
        name,
        voteAverage,
        voteCount,
      ];
}