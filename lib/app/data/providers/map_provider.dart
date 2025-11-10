// part of 'providers.dart';

// class MapProvider {
//   Future<List<MapModel>> get_option_place(String filter) async {
//     try {
//       final storage = new FlutterSecureStorage();
//       final String baseUrl = dotenv.env['BASE_URL'] ?? '';
//       final String? token = await storage.read(key: 'token');
//       final response = await http.get(
//         Uri.parse(
//             'https://us1.locationiq.com/v1/search.php?key=pk.352d883cedfc088c2ad81167d4b4b673&q=$filter&format=json'),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List results = json.decode(response.body);
//         return (results as List).map((e) => MapModel.fromJson(e)).toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
