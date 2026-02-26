import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/api_service.dart';
import '../utils/colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1.5.w,
          ),
        ),
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
      onPressed: () async {
        final api = ApiService();
        final user = await api.fetchUser(1);

        if (context.mounted) {
          _showProfileSheet(context, user);
        }
      },
    );
  }

  void _showProfileSheet(
      BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// 🔹 Drag Indicator
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              SizedBox(height: 20.h),

              /// 🔹 Avatar
              CircleAvatar(
                radius: 40.r,
                backgroundColor:
                AppColors.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: 50.sp,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 16.h),

              /// 🔹 Name
              Text(
                "${user['name']['firstname'].toString().toUpperCase()} "
                    "${user['name']['lastname'].toString().toUpperCase()}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 4.h),

              /// 🔹 Email
              Text(
                user['email'] ?? "Customer",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                ),
              ),

              SizedBox(height: 24.h),
              const Divider(),

              /// 🔹 Options
              _buildProfileOption(Icons.shopping_bag_outlined, "My Orders"),
              _buildProfileOption(Icons.favorite_border, "My Wishlist"),

              SizedBox(height: 20.h),

              /// 🔹 Close Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "CLOSE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileOption(
      IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 4.h,
      ),
      leading: Icon(
        icon,
        color: Colors.black87,
        size: 22.sp,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14.sp,
      ),
    );
  }
}