part of 'tv_bloc.dart';

abstract class TvStateBloc extends Equatable {
  const TvStateBloc();
  
  @override
  List<Object> get props => [];
}

class TvLoading extends TvStateBloc {}

class TvEmpty extends TvStateBloc {}

class TvHasData extends TvStateBloc {
  final List<Tv> tv;

  const TvHasData(this.tv);

  @override
  List<Object> get props => [tv];
}

class TvError extends TvStateBloc {
  final String message;

  const TvError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailState extends TvStateBloc{
  final TvDetail tv;

  TvDetailState(this.tv);

  @override
  List<Object> get props => [tv];
}

class WatchlistTvState extends TvStateBloc{
  final List<Tv> tv;

  WatchlistTvState(this.tv);

  @override
  List<Object> get props => [tv];
}

class WatchlistTvMessage extends TvStateBloc{
  final String message;
  const WatchlistTvMessage(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistTvStatusState extends TvStateBloc {
  final bool status;

  const WatchlistTvStatusState(this.status);

  @override
  List<Object> get props => [status];
}

// SEARCH MOVIE
class SearchStateTv extends Equatable {
  const SearchStateTv();
  
  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchStateTv {}

class SearchLoading extends SearchStateTv {}

class SearchError extends SearchStateTv {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvHasData extends SearchStateTv {
  final List<Tv> result;

  SearchTvHasData(this.result);

  @override
  List<Object> get props => [result];

}

class TvDetailDataState extends SearchStateTv{
  final TvDetail tv;

  TvDetailDataState(this.tv);

  @override
  List<Object> get props => [tv];
}