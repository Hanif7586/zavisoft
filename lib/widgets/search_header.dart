import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';
import 'profile_widget.dart';

class SearchHeader extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final TextEditingController controller;

  const SearchHeader({
    super.key,
    required this.onSearchChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [

          Expanded(
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                controller: controller,
                onChanged: onSearchChanged,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  hintText: "Search in Daraz",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
                  suffixIcon: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey,
                    size: 20.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),


          Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 22.sp,
          ),

          SizedBox(width: 8.w),


          const ProfileWidget(),
        ],
      ),
    );
  }
}