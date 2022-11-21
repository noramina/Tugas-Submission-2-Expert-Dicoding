import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  
  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      context.read<WatchlistTvBloc>().add(FetchWatchlistTv())
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvBloc>().add(FetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, TvStateBloc>(
          builder: (context, state) {
            if (state is TvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvState) {
              if (state.tv.length < 1) {
                return Center(
                  child: Text('No movies added yet'),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.tv[index];
                    return TvCard(tv);
                  },
                  itemCount: state.tv.length,
                );
              }
            } else if (state is TvError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Text('can\'t load data');
            }
          },
        )
      ),
    );
  }
   @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
