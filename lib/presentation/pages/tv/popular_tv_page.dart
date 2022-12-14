import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularTvBloc>().add(FetchPopularTv())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, TvStateBloc>(
            builder: (context, state) {
              if (state is TvLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TvHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final popularTv = state.tv[index];
                    return TvCard(popularTv);
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
