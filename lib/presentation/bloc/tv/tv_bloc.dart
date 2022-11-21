import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
part 'tv_event.dart';
part 'tv_state.dart';

class NowPlayingTvBloc extends Bloc<TvEventBloc, TvStateBloc>{
  final GetOnAiringTv _getOnAiringTv;

  NowPlayingTvBloc(this._getOnAiringTv) : super(TvLoading()){
    on<FetchOnAiringTv>((event, emit) async {
      
      emit(TvLoading());

      final result = await _getOnAiringTv.execute();

      result.fold(
        (failure){
        emit(TvError(failure.message));
        }, 
        (data) {
          emit(TvHasData(data));
        });
    });
  }
}

class PopularTvBloc extends Bloc<TvEventBloc, TvStateBloc>{
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(TvLoading()){
    on<FetchPopularTv>((event, emit) async {
      
      emit(TvLoading());

      final result = await _getPopularTv.execute();

      result.fold(
        (failure){
        emit(TvError(failure.message));
        }, 
        (data) {
          emit(TvHasData(data));
        });
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEventBloc, TvStateBloc>{
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(TvLoading()){
    on<FetchTopRatedTv>((event, emit) async {
      
      emit(TvLoading());

      final result = await _getTopRatedTv.execute();

      result.fold(
        (failure){
        emit(TvError(failure.message));
        }, 
        (data) {
          emit(TvHasData(data));
        });
    });
  }
}

class TvDetailBloc extends Bloc<TvEventBloc, TvStateBloc> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvLoading()) {
    on<FetchDetailTv>((event, emit) async {
      final id = event.id;

      emit(TvLoading());

      final result = await _getTvDetail.execute(id);

      result.fold(
        (failure) {
        emit(TvError(failure.message));
      }, (data) {
        emit(TvDetailState(data));
      });
    });
  }
}

class TvRecommendationBloc extends Bloc<TvEventBloc, TvStateBloc>{
  final GetTvRecommendations _getTvRecommendations;

  TvRecommendationBloc(this._getTvRecommendations) : super(TvLoading()){
    on<FetchTvRecommendation>((event, emit) async {
      
      final int id = event.id;

      emit(TvLoading());

      final result = await _getTvRecommendations.execute(id);

      result.fold(
        (failure){
        emit(TvError(failure.message));
        }, 
        (data) {
          emit(TvHasData(data));
        });
    });
  }
}


class WatchlistTvBloc extends Bloc<TvEventBloc, TvStateBloc> {
  final GetWatchlistTv _getWatchlistTv;
  final GetTvWatchListStatusTv _getWatchListStatusTv;
  final SaveTvWatchlist _saveWatchlistTv;
  final RemoveTvWatchlist _removeWatchlistTv;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistTvBloc(this._getWatchlistTv, this._getWatchListStatusTv,
      this._saveWatchlistTv, this._removeWatchlistTv)
      : super(TvEmpty()) {
    on<FetchWatchlistTv>((event, emit) async {
        emit(TvLoading());

        final result = await _getWatchlistTv.execute();
        result.fold((failure) {
          emit(
            TvError(failure.message));
        }, (data) {
          emit(WatchlistTvState(data));
        });
      },
    );

    on<SaveWatchistTv>((event, emit) async {
      final tV = event.tV;
      emit(TvLoading());
      final result = await _saveWatchlistTv.execute(tV);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (successMessage) {
          emit(
            WatchlistTvMessage(successMessage),
          );
        },
      );
    });

    on<RemoveWatchlistTvEvent>((event, emit) async {
      final tv = event.tv;
      emit(TvLoading());
      final result = await _removeWatchlistTv.execute(tv);

      result.fold((failure) => emit(TvError(failure.message)),
              (data) => emit(WatchlistTvMessage(data)));
    });

    on<WatchlistTvStatus>((event, emit) async {
      final id = event.id;
      emit(TvLoading());
      final result = await _getWatchListStatusTv.execute(id);

      emit(WatchlistTvStatusState(result));
    });
  }
}

// SEARCH MOVIE
class SearchTvBloc extends Bloc<SearchEventTv, SearchStateTv> {
  final SearchTv _searchTv;

  SearchTvBloc(this._searchTv) : super(SearchEmpty()) {
    on<OnQueryChangedTv>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());

      final result = await _searchTv.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

