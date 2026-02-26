import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';

class SpecialBanner extends StatefulWidget {
  const SpecialBanner({super.key});

  @override
  State<SpecialBanner> createState() => _SpecialBannerState();
}

class _SpecialBannerState extends State<SpecialBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
    _shimmerAnimation = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.primaryGradientColors,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGradientColors.last.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            Positioned(
              right: -30.w,
              top: -20.h,
              child: Container(
                width: 130.w,
                height: 130.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
            ),
            Positioned(
              right: 40.w,
              bottom: -35.h,
              child: Container(
                width: 90.w,
                height: 90.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _shimmerAnimation,
              builder: (context, child) {
                return Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(_shimmerAnimation.value - 1, 0),
                        end: Alignment(_shimmerAnimation.value, 0),
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.h),

                        Text(
                          'Limited time — don\'t miss out!',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '🎉',
                                style: TextStyle(fontSize: 10.sp),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'FLASH SALE TODAY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Right: CTA button

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}