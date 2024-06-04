// ignore_for_file: avoid_print

import "dart:io";
import "dart:typed_data";

import "package:dio/dio.dart";
import "package:dio/io.dart";
import "package:tubes_pinwave/api/endpoint/album/name/album_name_request.dart";
import "package:tubes_pinwave/api/endpoint/change_password/change_password_request.dart";
import "package:tubes_pinwave/api/endpoint/pin/comment/pin_comment_request.dart";
import "package:tubes_pinwave/api/endpoint/pin/pin_save_to_album_request.dart";
import "package:tubes_pinwave/api/endpoint/pin/report/pin_report_request.dart";
import "package:tubes_pinwave/api/endpoint/sign_in/sign_in_request.dart";
import "package:tubes_pinwave/api/endpoint/sign_up/sign_up_request.dart";
import "package:tubes_pinwave/api/interceptor/authorization_interceptor.dart";
import "package:tubes_pinwave/api/interceptor/custom_log_interceptor.dart";
import "package:tubes_pinwave/constant.dart";

class ApiManager {
  static Future<Dio> getDio({
    bool manager = false,
    bool alternative = false,
  }) async {
    String baseUrl = ApiUrl.MAIN_BASE;

    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        contentType: Headers.jsonContentType,
      ),
    );

    dio.interceptors.add(AuthorizationInterceptor());
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.interceptors.add(CustomLogInterceptor());

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient httpClient = HttpClient();

      httpClient.badCertificateCallback = (cert, host, port) => true;

      return httpClient;
    };

    return dio;
  }

  static Future<Uint8List> download({required String url}) async {
    Response response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));

    return response.data;
  }

  static Future<Response> signIn({
    required SignInRequest signInRequest,
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.post(
        ApiUrl.SIGN_IN,
        data: signInRequest,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> signUp({
    required SignUpRequest signUpRequest,
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.post(
        ApiUrl.SIGN_UP,
        data: signUpRequest,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> signOut() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.put(
        ApiUrl.SIGN_OUT,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> homePin() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        ApiUrl.HOME_PIN,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> searchPin({
    required String keyword,
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        ApiUrl.SEARCH_PIN,
        queryParameters: {
          "keyword": keyword
        }
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> getUser() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        ApiUrl.USER,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> getPinDetail({
    required int pinId
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        "${ApiUrl.PIN_DETAIL}/$pinId",
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> pinSaveRemove({
    required PinSaveToAlbumRequest pinSaveToAlbumRequest
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.post(
        ApiUrl.PIN_SAVE_REMOVE,
        data: pinSaveToAlbumRequest
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  // FORM DATA
  static Future<Response> postCreatePin({
    required PinSaveToAlbumRequest pinSaveToAlbumRequest
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.post(
          ApiUrl.CREATE_PIN,
          data: pinSaveToAlbumRequest
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> postCreateComment({
    required PinCommentRequest pinCommentRequest
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.post(
          ApiUrl.CREATE_COMMENT,
          data: pinCommentRequest
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> putFollowUser({
    required int userId
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.put(
        "${ApiUrl.FOLLOW}/$userId",
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> putReportPin({
    required int pinId,
    required PinReportRequest pinReportRequest,
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.put(
        "${ApiUrl.REPORT}/$pinId",
        data: pinReportRequest
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> putLikePin({
    required int pinId
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.put(
        "${ApiUrl.LIKE}/$pinId",
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> getNotification() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        ApiUrl.NOTIFICATION,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> getNotificationUnread() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        ApiUrl.NOTIFICATION_UNREAD,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> putNotificationReadById({
    required String notificationId
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.put(
        "${ApiUrl.NOTIFICATION_READ_BY_ID}/$notificationId",
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> putNotificationReadAll() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.put(
        ApiUrl.NOTIFICATION_READ_ALL,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  // FORM DATA
  static Future<Response> postChangeProfile() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.post(
        ApiUrl.CHANGE_PROFILE,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> putChangePassword({
    required ChangePasswordRequest changePasswordRequest,
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.put(
        ApiUrl.CHANGE_PASSWORD,
        data: changePasswordRequest,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> getAccount() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        ApiUrl.ACCOUNT,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> getPinAlbum({
    required albumId
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        "${ApiUrl.PIN_ALBUM_DETAIL}/$albumId",
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> getAlbumName() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        ApiUrl.ALBUM,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> getAlbumThumbnail() async {
    try {
      Dio dio = await getDio();

      Response response = await dio.get(
        ApiUrl.ALBUM_THUMBNAIL,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }

  static Future<Response> postAlbumName({
    required AlbumNameRequest albumNameRequest,
  }) async {
    try {
      Dio dio = await getDio();

      Response response = await dio.post(
        ApiUrl.ALBUM_ADD,
        data: albumNameRequest,
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        rethrow;
      }

      print(e.toString());

      rethrow;
    }
  }


}
