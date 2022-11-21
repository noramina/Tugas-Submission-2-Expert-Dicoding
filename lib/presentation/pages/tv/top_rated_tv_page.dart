import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';
  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedTvBloc>().add(FetchTopRatedTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TvStateBloc>(
            builder: (context, state) {
              if (state is TvLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TvHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.tv[index];
                    return TvCard(tv);
                  },
                  itemCount: state.tv.length,
                );
              } else if (state is TvError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Text('Tidak dapat menemukan tv'),
                );
              }
            }
      ),
      ),
    );
  }
}
