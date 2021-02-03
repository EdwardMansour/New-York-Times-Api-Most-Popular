import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get_it/get_it.dart';
import 'package:ny_times/model/repositories/ny_times_most_popular_repo.dart';
import 'package:ny_times/model/repositories/ny_times_serices.dart';

import 'dio_connectivity_request_retrier.dart';

final sl = GetIt.instance;

void init() {
  //todo: Dio Cache duration
  sl.registerLazySingleton(
    () => buildCacheOptions(Duration(days: 0), forceRefresh: true),
  );
  //todo: Dio Cache Config
  sl.registerLazySingleton(
    () => CacheConfig(),
  );
//todo: Dio cache Manager
  sl.registerLazySingleton(
    () => DioCacheManager(
      sl(),
    ),
  );
  //todo: Connectivity
  sl.registerLazySingleton(
    () => Connectivity(),
  );
  //!todo: Connectivity request Retriver
  sl.registerLazySingleton(
    () => DioConnectivityRequestRetrier(
      connectivity: sl(),
      dio: sl(),
    ),
  );
  //todo : should retry funtion
  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT &&
        err.error != null &&
        err.error is SocketException;
  }

  //todo :Dio http client
  sl.registerLazySingleton(
    () => new Dio()
      ..options.headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      }
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options) async {
            // todo : we can add condition to header if the token key (Bearer) if not available
            return options;
          },
          onResponse: (Response response) {
            return response; // continue
          },
          onError: (DioError e) async {
            if (_shouldRetry(e)) {
              try {
                return sl<DioConnectivityRequestRetrier>()
                    .scheduleRequestRetry(e.request);
              } catch (error) {
                // todo: Let any new error from the retrier pass through
                return error;
              }
            }
            if (e.response.statusCode == 401) {
              //todo: unauthorized
            }
            print(e);
            return e;
          },
        ),
      )
      ..interceptors.add(
        sl<DioCacheManager>().interceptor,
      ),
  );

  //todo: serice
  sl.registerLazySingleton(
    () => NyTimesServices(
      dio: sl(),
    ),
  );

  //todo: repository
  sl.registerLazySingleton(
    () => NyTimesMostPopularRepo(
      nyTimesSerices: sl(),
    ),
  );
}
