import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NowPlayingMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/nowplaying-movie';

  const NowPlayingMoviePage({Key? key}) : super(key: key);

  @override
  State<NowPlayingMoviePage> createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NowPlayingMovieBloc>().add
        (FetchNowPlayingMovies())
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingMovieBloc, MovieStateBloc>(
            builder: (context, state) {
              if (state is MoviesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MoviesHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final nowOnAiringTv = state.movie[index];
                    return MovieCard(nowOnAiringTv);
                  },
                  itemCount: state.movie.length,
                );
              } else if (state is MoviesError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return  Text('Tidak dapat menemukan film ');
              }
            },
          )
      ),
    );
  }
}
