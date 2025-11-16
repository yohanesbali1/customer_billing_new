import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class ChatRepository {
  final ApiProvider api;

  ChatRepository({required this.api});

  Future<ChatResponseModel> getChatData({
    int page = 1,
    int perPage = 10,
    int? id,
  }) async {
    try {
      print('/customer/complaint/$id/chat?page=$page&per_page=$perPage');
      final response = await api.get(
        '/customer/complaint/$id/chat?page=$page&per_page=$perPage',
      );
      return ChatResponseModel.fromJson(response);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> submitChat(form) async {
    try {
      final imageFile = form['image'];
      await api.post(
        '/customer/complaint${form['id'] != '' ? '/${form['id']}' : ''}/chat',
        form,
        files: imageFile == null
            ? null
            : {
                "image": imageFile.path, // pastikan String
              },
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteChat(dynamic id) async {
    try {
      await api.delete('/customer/complaint/chat/$id');
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
