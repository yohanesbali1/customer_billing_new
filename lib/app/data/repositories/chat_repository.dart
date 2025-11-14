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
      final response = await api.get(
        '/customer/complaint/$id/chat?page=$page&per_page=$perPage',
      );
      return ChatResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> submitChat(form) async {
    try {
      await api.post(
        '/customer/complaint${form['id']}/chat',
        form,
        files: form.image,
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
