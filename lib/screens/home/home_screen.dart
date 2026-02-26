import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/search_header.dart';
import '../../widgets/special_banner.dart';
import '../../widgets/sticky_tab_bar_delegate.dart';
import '../../widgets/product_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  final List<String> tabs = const [
    "All",
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    Future.microtask(() {
      context.read<HomeProvider>().fetchProducts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => context.read<HomeProvider>().fetchProducts(),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  expandedHeight: 180.h,
                  pinned: true,
                  floating: true,
                  snap: true,
                  backgroundColor: AppColors.primary,
                  surfaceTintColor: AppColors.primary,
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  title: SearchHeader(
                    controller: _searchController,
                    onSearchChanged: (v) =>
                        setState(() => searchQuery = v.toLowerCase()),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: const SpecialBanner(),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1.w,
                        ),
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.primary,
                      indicatorWeight: 3.w,
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: tabs
                          .map((t) => Tab(text: t.toUpperCase()))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: tabs.map((category) {
              return Builder(
                builder: (context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(category),
                    slivers: [
                      SliverOverlapInjector(
                        handle:
                        NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      ProductGridView(
                        category: category,
                        searchQuery: searchQuery,
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}