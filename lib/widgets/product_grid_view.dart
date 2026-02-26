import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../utils/colors.dart';
import 'product_card.dart';

class ProductGridView extends StatelessWidget {
  final String category;
  final String searchQuery;

  const ProductGridView({
    super.key,
    required this.category,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    final items = provider.products.where((p) {
      final matchesCat = category == "All" || p.category == category;
      return matchesCat &&
          p.title.toLowerCase().contains(searchQuery);
    }).toList();


    if (provider.isLoading) {
      return SliverFillRemaining(
        child: Center(
          child: SizedBox(
            width: 30.w,
            height: 30.w,
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 3.w,
            ),
          ),
        ),
      );
    }

    if (items.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            "No products found!",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.all(10.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,

          childAspectRatio: 0.68,

          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) =>
              ProductCard(product: items[index]),
          childCount: items.length,
        ),
      ),
    );
  }
}