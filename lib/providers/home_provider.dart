import 'package:flutter/material.dart';
import 'package:zavisoft/models/product_model.dart';
import '../core/api_service.dart';


class HomeProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<Product> products = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      products = await _api.fetchProducts();
    } catch (e) {
      debugPrint("Error fetching products: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  List<Product> byCategory(String category) {
    if (category.toLowerCase() == "all") return products;
    return products.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
  }
}