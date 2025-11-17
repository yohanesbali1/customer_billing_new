import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class ChatRepository {
  final ApiProvider api;

  ChatRepository({required this.api});

  Future<List<ChatModel>> getChatData(String id) async {
    try {
      final response = await api.get('/customer/complaint/$id/chat');
      return List<ChatModel>.from(
        response['data'].map((x) => ChatModel.fromJson(x)),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> submitChat(form) async {
    try {
      final imageFile = form['image'];
      Map<String, String>? files;
      if (imageFile != null) {
        files = {
          'img': imageFile.path, // ambil path dari File
        };
      }

      await api.post(
        '/customer/complaint${form['id'] != '' ? '/${form['id']}' : ''}/chat',
        form,
        files: files,
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
