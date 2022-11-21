import 'package:ditonton/domain/repositories/tv_repository.dart';
class GetTvWatchListStatusTv {
  final TvRepository repository;

  GetTvWatchListStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
