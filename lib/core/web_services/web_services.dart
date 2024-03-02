import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../error/exceptions.dart';

class WebServices {
  var client = http.Client();

  Future<http.Response> getData({required String endPoint}) async {
    final response = await client.get(Uri.parse('$baseUrl$endPoint'));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw ServerException();
    }
  }

  Future<Unit> postData(
      {required Map<String, dynamic> body, required String endPoint}) async {
    final response =
        await client.post(Uri.parse('$baseUrl$endPoint'), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  Future<Unit> deleteData({required String endPoint}) async {
    final response = await client.delete(Uri.parse('$baseUrl$endPoint'));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  Future<Unit> updateData(
      {required String endPoint, required Map<String, dynamic> body}) async {
    final response =
        await client.put(Uri.parse('$baseUrl$endPoint'), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
