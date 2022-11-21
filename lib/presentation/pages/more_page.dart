import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  static const ROUTE_NAME = '/morepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('more'),
        ),
        body: Column(children: [
          ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              }),
          ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Tv'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
              })
        ]));
  }
}
