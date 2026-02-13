import 'dart:io';

import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class HelpRepository {
  final ApiProvider api;

  HelpRepository({required this.api});

  Future<HelpResponseModel> getHelpData({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await api.get(
        '/customer/complaint?page=$page&per_page=$perPage',
      );
      return HelpResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<HelpModel?> showHelpData(dynamic id) async {
    try {
      final response = await api.get('/customer/complaint/$id');
      return HelpModel.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> submitHelp(
    String id,
    Map<String, dynamic> form,
    File? file,
  ) async {
    try {
      Map<String, String>? files;

      if (file != null) {
        files = {
          'img': file.path, // ambil path dari File
        };
      }

      await api.post(
        '/customer/complaint${id == '' ? '' : '/$id'}',
        form,
        files: files,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteHelp(dynamic id) async {
    try {
      await api.delete('/customer/complaint/$id');
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DisorderCategory>> getTypeHelp() async {
    try {
      final response = await api.get('/customer/type-complaint');
      return (response['data'] as List)
          .map((e) => DisorderCategory.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
