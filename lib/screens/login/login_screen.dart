import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zavisoft/utils/colors.dart';
import '../home/home_screen.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final userCtrl = TextEditingController(text: "mor_2314");
  final passCtrl = TextEditingController(text: "83r5^_");

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.isLoggedIn) {
      return const HomeScreen();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 10.r,
                        offset: Offset(0, 5.h),
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                    size: 48.sp,
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  'Daraz Clone',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Sign in to continue shopping',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 40.h),


                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [


                        TextField(
                          controller: userCtrl,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(fontSize: 14.sp),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: AppColors.primary,
                              size: 22.sp,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),


                        TextField(
                          controller: passCtrl,
                          obscureText: true,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 14.sp),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.primary,
                              size: 22.sp,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          'Test: mor_2314 / 83r5^_',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 24.h),


                        ElevatedButton(
                          onPressed: auth.isLoading
                              ? null
                              : () {
                            context.read<AuthProvider>().login(
                              userCtrl.text,
                              passCtrl.text,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            elevation: 0,
                          ),
                          child: auth.isLoading
                              ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.w,
                            ),
                          )
                              : Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}