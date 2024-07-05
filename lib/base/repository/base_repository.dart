import 'package:flutter/material.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';

class BaseRepository {
  Future<DataResult<T>> resultWithFuture<T>({
    required Future<T> Function() future,
  }) async {
    try {
      var data = await future.call();
      return Success(data: data);
    } on ApiException catch (e) {
      _printError(e);
      return Error(exception: e);
    } catch (e) {
      _printError(e);
      return Error(exception: null);
    }
  }

  void _printError(dynamic e) {
    debugPrint('\n' * 2);
    debugPrint('${'***' * 10} ERROR ${'***' * 10}');
    debugPrint('Error: ${e?.toString()}');
    debugPrint('${'***' * 10} ----- ${'***' * 10}');
    debugPrint('\n' * 2);
  }
}
