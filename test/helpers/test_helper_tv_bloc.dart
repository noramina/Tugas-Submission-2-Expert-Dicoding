import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class NowPlayingTvHelper extends Fake implements TvEventBloc {}

class NowPlayingTvStateHelper extends Fake implements TvStateBloc {}

class NowPlayingTvBlocHelper extends MockBloc<TvEventBloc, TvStateBloc>
    implements NowPlayingTvBloc {}

class PopularTvEventBlocHelper extends Fake implements TvEventBloc {}

class PopularTvStateHelper extends Fake implements TvStateBloc {}

class PopularTvBlocHelper extends MockBloc<TvEventBloc, TvStateBloc>
    implements PopularTvBloc {}

class TopRatedTvEventBlocHelper extends Fake implements TvEventBloc {}

class TopRatedTvStateHelper extends Fake implements TvStateBloc {}

class TopRatedTvBlocHelper extends MockBloc<TvEventBloc, TvStateBloc>
    implements TopRatedTvBloc {}

class TvDetailEventHelper extends Fake implements TvEventBloc {}

class TvDetailStateHelper extends Fake implements TvStateBloc {}

class TvDetailBlocHelper extends MockBloc<TvEventBloc, TvStateBloc>
    implements TvDetailBloc {}

class TvRecommendationEventBlocHelper extends Fake implements TvEventBloc {}

class TvRecommendationStateHelper extends Fake implements TvStateBloc {}

class TvRecommendationBlocHelper extends MockBloc<TvEventBloc, TvStateBloc>
    implements TvRecommendationBloc {}

class WatchlistTvEventBlocHelper extends Fake implements TvEventBloc {}

class WatchlistTvStateHelper extends Fake implements TvStateBloc {}

class WatchlistTvBlocHelper extends MockBloc<TvEventBloc, TvStateBloc>
    implements WatchlistTvBloc {}
