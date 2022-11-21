part of 'tv_bloc.dart';

abstract class TvEventBloc extends Equatable {
  const TvEventBloc();

  @override
  List<Object> get props => [];
}


class FetchOnAiringTv extends TvEventBloc{}
class FetchPopularTv extends TvEventBloc{}
class FetchTopRatedTv extends TvEventBloc{}
class FetchWatchlistTv extends TvEventBloc {}


class FetchDetailTv extends TvEventBloc{
  final int id;
  
  FetchDetailTv(this.id);

  @override
  List<Object> get props => [id];
}
class FetchTvRecommendation extends TvEventBloc {
  final int id;
  const FetchTvRecommendation(this.id);

  @override
  List<Object> get props => [id];
}

class SaveWatchistTv extends TvEventBloc {
  final TvDetail tV;

  const SaveWatchistTv(this.tV);
  @override
  List<Object> get props => [tV];
}

class RemoveWatchlistTvEvent extends TvEventBloc {
  final TvDetail tv;

  const RemoveWatchlistTvEvent(this.tv);
  @override
  List<Object> get props => [tv];
}

class WatchlistTvStatus extends TvEventBloc {
  final int id;

  const WatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}

// SEARCH TV 
class SearchEventTv extends Equatable {
  const SearchEventTv();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTv extends SearchEventTv{
  final String query;

  OnQueryChangedTv(this.query);

  @override
  List<Object> get props => [query];
}


