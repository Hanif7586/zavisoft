import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';

class ProductCard extends StatelessWidget {
  final dynamic product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4.r,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Center(
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE0D3),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      "Free Shipping",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8.h),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),


                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          "4.5",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}