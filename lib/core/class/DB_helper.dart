import 'package:dartz/dartz.dart';
import 'package:dashboard/core/class/statusRequest.dart';
import 'package:dashboard/core/functions/checkInternetConncetion.dart';
import 'package:dio/dio.dart';

class DB_helper {
  final dio = Dio();

  Future<Either<StatusRequest, Map>> login(String url, data) async {
    if (await checkInternetConnection()) {
      try {
        var response = await dio.post(url, data: data);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Map responseBody = response.data;

          return Right(response.data);
        } else {
          return const Left(StatusRequest.failure);
        }
      } on DioException catch (e) {
        print(e.error);
        print(e.message);

        return const Left(StatusRequest.failure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> postData(String url, data,
      {String? userToken}) async {
    // dio.options.headers["Content-Type"] = "multipart/form-data";
    if (await checkInternetConnection()) {
      try {
        var response = await dio.post(url,
            data: data,
            options: Options(headers: {
              "Accept": "*/*",
              'Authorization': 'Bearer $userToken',
              // "Content-Type": "multipart/form-data"
            }));

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Map responseBody = response.data;

          return Right(response.data);
        } else {
          return const Left(StatusRequest.failure);
        }
      } on DioException catch (e) {
        print(e.error);
        print(e.message);

        return const Left(StatusRequest.failure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> patchData(String url, data,
      {String? userToken}) async {
    try {
      if (await checkInternetConnection()) {
        var response = await dio.patch(url,
            data: data,
            options: Options(headers: {
              "Accept": "*/*",
              'Authorization': 'Bearer $userToken'
            }));

        // Map responseBody = response.data;

        return Right(response.data);
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } on DioException catch (e) {
      print(e.message);
      return const Left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, Map>> getAllData(String url,
      {String? userToken}) async {
    if (await checkInternetConnection()) {
      try {
        var response = await dio.get(url,
            options: Options(headers: {'Authorization': 'Bearer $userToken'}));
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Map responseBody = response.data;
          return Right(response.data);
        }
        return const Left(StatusRequest.failure);
      } on DioException catch (e) {
        print(e.message);

        return const Left(StatusRequest.failure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> deleteData(
      String url, String userToken) async {
    if (await checkInternetConnection()) {
      try {
        var response = await dio.delete(url,
            options: Options(headers: {'Authorization': 'Bearer $userToken'}));

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Map responseBody = response.data;

          return Right(response.data);
        } else {
          return const Left(StatusRequest.failure);
        }
      } on DioException catch (e) {
        print(e.message);
        return const Left(StatusRequest.failure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }
}
