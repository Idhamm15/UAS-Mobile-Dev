// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class TaskService {
  Future<http.Response?> getTask() async {
    const _baseUrl = 'localhost:8080'; // authority
    const _path = '/tasks'; // path

    try {
      final url = Uri.http(_baseUrl, _path);
      final response = await http.get(url);
      return response;
      print('koneksi service oke');
    } catch (e) {
      rethrow;
    }
  }
}
