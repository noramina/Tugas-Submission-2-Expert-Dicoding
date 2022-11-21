import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/more_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/now_playing_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/movie_page';
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<NowPlayingMovieBloc>().add(FetchNowPlayingMovies());
      context.read<PopularMovieBloc>().add(FetchPopularMovies());
      context.read<TopRatedMovieBloc>().add(FetchTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Colors.white,
        gap: 10,
        padding: EdgeInsets.all(16),
        tabs: [
          GButton(
            icon: Icons.movie,
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeMoviePage())
              ),
              
            },
          ),
          GButton(
            icon: Icons.tv,
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeTvPage())
              ),
            },
          ),
          GButton(
            icon: Icons.help,
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  AboutPage())
              ),
            },
            text: 'About',
          ),
          GButton(
            icon: Icons.more,
            onPressed: () => {
             Navigator.push(context, MaterialPageRoute(builder: (context) =>  MorePage())
              ),
            },
            text: 'More',

          ),
        ],
      ),
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NowPlayingMoviePage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingMovieBloc, MovieStateBloc>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return Center(child: CircularProgressIndicator());
                  }else if(state is MoviesHasData){
                    return MovieList(state.movie);
                  }else if(state is MoviesError){
                    return Center(child: Text(state.message),);
                  }else{
                    return Center(child: Text('Tidak dapat menemukan film '),);
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMovieBloc, MovieStateBloc>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return Center(child: CircularProgressIndicator());
                  }else if(state is MoviesHasData){
                    return MovieList(state.movie);
                  }else if(state is MoviesError){
                    return Center(child: Text(state.message),);
                  }else{
                    return Center(child: Text('Tidak dapat menemukan film'),);
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMovieBloc, MovieStateBloc>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return Center(child: CircularProgressIndicator());
                  }else if(state is MoviesHasData){
                    return MovieList(state.movie);
                  }else if(state is MoviesError){
                    return Center(child: Text(state.message),);
                  }else{
                    return Center(child: Text('Tidak dapat menemukan film'),);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
