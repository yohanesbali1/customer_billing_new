part of 'providers.dart';

class AuthProvider {
  final storage = new FlutterSecureStorage();
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<dynamic> loginData(form) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        body: form,
        headers: {'Accept': 'application/json'},
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        // var userCredential = await FirebaseAuth.instance
        //     .signInWithCustomToken(data['token_firebase']);
        return LoginModel.fromJson(data);
      }
      throw data['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileModel?> getData() async {
    try {
      final String? token = await storage.read(key: 'token');
      final http.Response response = await http.get(
        Uri.parse('$baseUrl/customer/auth/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<dynamic, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(responseData['data']);
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateData(form) async {
    try {
      final String? token = await storage.read(key: 'token');
      final http.Response response = await http.post(
        Uri.parse('$baseUrl/customer/auth/change-password'),
        body: form,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<dynamic, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
      if (response.statusCode == 422) {
        throw responseData['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic?> deleteData() async {
    try {
      final String? token = await storage.read(key: 'token');
      final http.Response response = await http.get(
        Uri.parse('$baseUrl/auth/delete-account'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
      if (response.statusCode == 200) {
        await storage.deleteAll();
        return null;
      }
      throw "Silahkan hubungin cs";
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic?> logoutData() async {
    try {
      final String? token = await storage.read(key: 'token');
      final http.Response response = await http.get(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
      if (response.statusCode == 200) {
        // await FirebaseAuth.instance.signOut();
        await storage.deleteAll();
        return null;
      }
      throw "Silahkan hubungin cs";
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateDataTokenFCM() async {
    try {
      final firebaseMessage = FirebaseMessaging.instance;
      final token_fcm = await firebaseMessage.getToken();
      final String? token = await storage.read(key: 'token');
      final form = {'id': token_fcm};
      final http.Response response = await http.post(
        Uri.parse('$baseUrl/auth/save-token'),
        body: form,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<dynamic, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 401) {
        storage.delete(key: 'token');
        Get.toNamed('/login');
        return null;
      }
      if (response.statusCode == 422) {
        throw responseData['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
