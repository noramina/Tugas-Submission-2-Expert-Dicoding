import 'package:ditonton/common/connection.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/db/tv_database.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';


@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvRemoteDataSource,
  MovieLocalDataSource,
  TvLocalDataSource,
  DatabaseHelper,
  TvDatabase,
  Connection,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
