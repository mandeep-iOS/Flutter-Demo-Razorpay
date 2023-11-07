import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter_razorpay_demo/constant/string_constants.dart";
import "package:flutter_razorpay_demo/model/books_model.dart";
import "package:flutter_razorpay_demo/model/razorpay_response.dart" as razor;
import "package:pretty_dio_logger/pretty_dio_logger.dart";

class DioSingleton {
  factory DioSingleton() {
    return _singleton;
  }

  DioSingleton._internal();
  static final DioSingleton _singleton = DioSingleton._internal();

  final Dio dio = Dio();
  final String razorpayBaseURL = "https://api.razorpay.com/";
  final String razorpayBaseVer = "v1/";
  final String razorpayBaseEnd = "orders";
  final String booksListLink = "https://www.jsonkeeper.com/b/6K25";

  Future<void> addPrettyDioLoggerInterceptor() {
    dio.interceptors.add(
      PrettyDioLogger(),
    );
    return Future<void>.value();
  }

  Future<Map<String, dynamic>> makePaymentIntent({
    required double amount,
    required String currency,
    required void Function(String) errorMessageFunction,
  }) async {
    final Map<String, dynamic> tempPaymentIntent = <String, dynamic>{};
    Response<dynamic> response = Response<dynamic>(
      requestOptions: RequestOptions(path: ""),
    );

    try {
      response = await dio.post(
        razorpayBaseURL + razorpayBaseVer + razorpayBaseEnd,
        queryParameters: <String, dynamic>{
          "amount": amount.toInt() * 100,
          "currency": "INR",
          "receipt": "receipt_id_${DateTime.now()}",
          "notes": <String, dynamic>{"note_key": "note_value"},
        },
        options: Options(
          headers: <String, dynamic>{
            "Content-Type": "application/json",
            ...getHeaders(),
          },
        ),
      );
      tempPaymentIntent.addAll(response.data);
    } on DioError catch (error) {
      razor.RazorpayResponse razorpayResponse = razor.RazorpayResponse();
      razorpayResponse = razor.RazorpayResponse.fromJson(error.response?.data);
      errorMessageFunction(razorpayResponse.message ?? "Unknown Error");
    }
    return Future<Map<String, dynamic>>.value(tempPaymentIntent);
  }

  Map<String, String> getHeaders() {
    final String keyID = StringConstants().publishableKey;
    final String keySecret = StringConstants().secretKey;
    final String credentials = "$keyID:$keySecret";
    final Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    final String encoded = stringToBase64Url.encode(credentials);
    final Map<String, String> headers = <String, String>{
      "Authorization": "Basic $encoded",
    };
    return headers;
  }

  Future<BooksModel> bookListAPI({
    required void Function(String) errorMessageFunction,
  }) async {
    BooksModel newModel = BooksModel();
    Response<dynamic> response = Response<dynamic>(
      requestOptions: RequestOptions(path: ""),
    );
    try {
      response = await dio.get(
        booksListLink,
        options: Options(
          headers: <String, dynamic>{
            "Content-Type": "application/json",
          },
        ),
      );
      newModel = BooksModel.fromJson(response.data);
    } on DioError catch (error) {
      errorMessageFunction(error.response?.statusMessage ?? "Unknown Error");
    }
    return Future<BooksModel>.value(newModel);
  }
}
