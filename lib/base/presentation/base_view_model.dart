import 'package:flutter/material.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/presentation/utils.dart';

abstract class BaseViewModel extends ChangeNotifier {
  Future<DataResult<T>> handleTaskWithResultReturn<T>({
    required OnFuture<DataResult<T>> onRequest,
    OnSuccess<T>? onSuccess,
    OnError? onError,
    bool showLoading = true,
    bool showErrorDialog = true,
    bool useOriginMessage = false,
  }) async {
    if (showLoading) Utils.showDialogLoading();
    var result = await onRequest.call();
    if (showLoading) Utils.popLoading();

    switch (result) {
      case Success<T>():
        onSuccess?.call(result.data);
      case Error<T>():
        if (showErrorDialog) {
          final exception = result.exception;
          String? title;
          String? message;
          if (exception is ApiException) {
            title = exception.title;
            if (useOriginMessage) {
              message = exception.message;
            }
            if (exception.type == ApiExceptionType.tokenExpires) {
              Utils.showTokenExpiredDialog();
              return result;
            }
          }
          Utils.showErrorDialog(
            title: title,
            message: message,
          );
        }
        onError?.call(result);
    }
    return result;
  }

  Future<void> handleTask<T>({
    required OnFuture<DataResult<T>> onRequest,
    OnSuccess<T>? onSuccess,
    OnError? onError,
    bool showLoading = true,
    bool showErrorDialog = true,
    bool useOriginMessage = false,
  }) async {
    if (showLoading) Utils.showDialogLoading();
    var result = await onRequest.call();
    if (showLoading) Utils.popLoading();

    switch (result) {
      case Success<T>():
        onSuccess?.call(result.data);
      case Error<T>():
        if (showErrorDialog) {
          final exception = result.exception;
          String? title;
          String? message;
          if (exception is ApiException) {
            title = exception.title;
            if (useOriginMessage) {
              message = exception.message;
            }
            if (exception.type == ApiExceptionType.tokenExpires) {
              Utils.showTokenExpiredDialog();
              return;
            }
          }
          Utils.showErrorDialog(
            title: title,
            message: message,
          );
        }
        onError?.call(result);
    }
  }

  Future<void> handleMultiTask({
    required List<Future<DataResult>> requests,
    OnSuccess? onSuccess,
    Function(List<Error<dynamic>> error)? onError,
    bool showLoading = true,
    bool showErrorDialog = true,
  }) async {
    if (showLoading) Utils.showDialogLoading();
    var result = await Future.wait(requests);
    if (showLoading) Utils.popLoading();
    final isSuccess = !result.map((e) => e is Success).contains(false);
    if (isSuccess) {
      onSuccess?.call(
        result.map(
          (e) {
            if (e is Success) {
              return e.data;
            }
          },
        ),
      );
    } else {
      if (showErrorDialog) {
        bool hasTokenExpiresException = result.map((e) {
          if (e is Error) {
            final exception = e.exception;
            if (exception is ApiException) {
              if (exception.type == ApiExceptionType.tokenExpires) {
                return true;
              }
            }
          }
          return false;
        }).contains(true);

        if (hasTokenExpiresException) {
          Utils.showTokenExpiredDialog();
          return;
        }
      }
      Utils.showErrorDialog();
    }
    onError?.call(
      result
          .map((e) {
            if (e is Error) {
              return e;
            }
          })
          .whereType<Error>()
          .toList(),
    );
  }
}

typedef OnSuccess<T> = void Function(T value);
typedef OnError = void Function(Error error);
typedef OnFuture<T> = Future<T> Function();
