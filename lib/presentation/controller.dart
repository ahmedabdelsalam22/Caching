import 'dart:io';

import 'package:data_caching/data/Employee.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class EmployeesController {
  static String url = "https://dummy.restapiexample.com/api/v1/employees";
  static List<Data> result = [];

  static Future<List<Data>?> getAllEmployees() async {
    try {
      Dio dio = Dio();
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options myOption =
          buildCacheOptions(const Duration(days: 30), forceRefresh: true);
      dio.interceptors.add(dioCacheManager.interceptor);

      var response = await dio.get(url, options: myOption);

      result = getList(response.data);
    } catch (e) {
      if (e is SocketException) {
        return null;
      }
    }
    return result;
  }
}

getList(body) {
  List<Data> emp = [];
  List x = (body)['data'];
  x.forEach((element) {
    emp.add(Data.fromJson(element));
  });

  return emp;
}
