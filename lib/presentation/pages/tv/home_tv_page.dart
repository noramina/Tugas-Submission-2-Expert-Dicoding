import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:ditonton/presentation/pages/more_page.dart';
import 'package:ditonton/presentation/pages/tv/now_playing_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/search_page_tv.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';

import 'package:cached_network_image/cached_network_image.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show';
  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvBloc>().add(FetchOnAiringTv());
      context.read<PopularTvBloc>().add(FetchPopularTv());
      context.read<TopRatedTvBloc>().add(FetchTopRatedTv());
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
        tabs:  [
           
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
              Navigator.pushNamed(context, SearchPageTv.ROUTE_NAME);
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
                    Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingTvBloc, TvStateBloc>(
                  builder: (context, state) {
                    if (state is TvLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TvHasData) {
                      return TvList(state.tv);
                    } else if (state is TvError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Tidak dapat menemukan tv');
                      
                    }
                  },
                ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, TvStateBloc>(
                  builder: (context, state) {
                    if (state is TvLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TvHasData) {
                      return TvList(state.tv);
                    } else if (state is TvError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Tidak dapat menemukan tv');
                      
                    }
                  },
                ),
              _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () =>
                      Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME)
                    ),
              BlocBuilder<TopRatedTvBloc, TvStateBloc>(
                  builder: (context, state) {
                    if (state is TvLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TvHasData) {
                      return TvList(state.tv);
                    } else if (state is TvError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Tidak dapat menemukan tv');
                      
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

class TvList extends StatelessWidget {
  final List<Tv> tvShow;

  TvList(this.tvShow);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvShow[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, TvDetailPage.ROUTE_NAME,
                    arguments: tv.id);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShow.length,
      ),
    );
  }
}
