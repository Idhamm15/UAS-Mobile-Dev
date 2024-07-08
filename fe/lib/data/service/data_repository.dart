// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class DataService {
  Future<http.Response?> getProduct() async {
    
    const _baseUrl = 'localhost:8080'; // authority
    const _path = '/api/products'; // path

    try {
      final url = Uri.http(_baseUrl, _path);
      final response = await http.get(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

