import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../utils/config.dart';

class ApiService {

  //login
  Future<bool> login(String username, String password) async {
    final url = Uri.parse("${AppConfig.baseUrl}/auth/login");

    final res = await http.post(
      url,
      body: {
        "username": username,
        "password": password,
      },
    );

    print("Login URL: $url");
    print("Status: ${res.statusCode}");
    print("Body: ${res.body}");

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = json.decode(res.body);
      print("Token: ${data['token']}");
      return true;
    } else {
      throw Exception("Login failed");
    }
  }

  //fetchproducts
  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse("${AppConfig.baseUrl}/products");

    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  //userprofile
  Future<Map<String, dynamic>> fetchUser(int id) async {
    final url = Uri.parse("${AppConfig.baseUrl}/users/$id");

    final res = await http.get(url);

    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception("Failed to load user");
    }
  }
}