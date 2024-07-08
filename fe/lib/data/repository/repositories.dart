import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fe/data/model/users_model.dart';

class UserRepository {
  static const String _baseUrl = 'http://localhost:8080/users'; // Base URL

  // Endpoint untuk mendapatkan daftar pengguna
  static const String _usersEndpoint = 'users';


  // Endpoint untuk login pengguna
  static const String _loginEndpoint = 'login';
  static const String _registerEndpoint = 'register';

  // Mendapatkan daftar pengguna dari server
  Future<List<UserModel>> getUsers() async {
    final Uri url = Uri.parse('$_baseUrl/$_usersEndpoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body)['data'];
      return responseData.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users: ${response.reasonPhrase}');
    }
  }

  // Melakukan proses login
  Future<UserModel> login(String email, String password) async {
    final Uri url = Uri.parse('$_baseUrl/$_loginEndpoint');
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
      headers: <String, String>{'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return UserModel.fromJson(responseData);
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }

  // Melakukan proses registrasi
  Future<UserModel> register(String fullName, String email, String password) async {
    final Uri url = Uri.parse('$_baseUrl/$_registerEndpoint');
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'fullname': fullName, 'email': email, 'password': password}),
      headers: <String, String>{'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body)['user'];
      return UserModel.fromJson(responseData);
    } else {
      throw Exception('Failed to register: ${response.reasonPhrase}');
    }
  }
}
