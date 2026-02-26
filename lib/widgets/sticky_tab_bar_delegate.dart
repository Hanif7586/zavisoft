import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyTabBarDelegate({required this.child});

  @override
  double get minExtent => 48.h;

  @override
  double get maxExtent => 48.h;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return SizedBox(
      height: 48.h,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant StickyTabBarDelegate oldDelegate) {
    return false;
  }
}