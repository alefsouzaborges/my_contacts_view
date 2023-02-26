// ignore_for_file: file_names
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioConnectController extends GetxController {
      BaseOptions baseOptions = BaseOptions(
      ////////////////////////////////////////////////////////////////
      //baseUrl: 'http://10.10.10.227/',
      connectTimeout: 5000,
      receiveTimeout: 30000,
    );
}
