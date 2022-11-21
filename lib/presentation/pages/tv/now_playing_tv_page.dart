import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv/tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/nowplaying-tv';

  const NowPlayingTvPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingTvPage> createState() => _NowPlayingTvPageTvPageState();
}

class _NowPlayingTvPageTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NowPlayingTvBloc>().add(FetchOnAiringTv())
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvBloc, TvStateBloc>(
            builder: (context, state) {
              if (state is TvLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TvHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final nowOnAiringTv = state.tv[index];
                    return TvCard(nowOnAiringTv);
                  },
                  itemCount: state.tv.length,
                );
              } else if (state is TvError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return  Text('Tidak dapat menemukan tv ');
              }
            },
          )
      ),
    );
  }
}
