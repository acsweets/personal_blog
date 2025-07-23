import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/blog_model.dart';
import '../routes/app_routes.dart';
import '../widgets/hero_banner.dart';
import '../widgets/post_card.dart';
import '../widgets/status_bar.dart';
import '../animations/page_transitions.dart';
import '../utils/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  final List<String> categories = ['全部', '技�?, '思维', '成长', '英语', '情绪'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideInAnimation(
          delay: const Duration(milliseconds: 100),
          child: const HeroBanner(),
        ),
        const SizedBox(height: 32),
        SlideInAnimation(
          delay: const Duration(milliseconds: 200),
          child: _buildCategoryFilter(),
        ),
        const SizedBox(height: 24),
        _buildLatestPosts(),
        const SizedBox(height: 32),
        SlideInAnimation(
          delay: const Duration(milliseconds: 400),
          child: _buildDailyGrowthEntry(),
        ),
        const SizedBox(height: 32),
        SlideInAnimation(
          delay: const Duration(milliseconds: 500),
          child: const StatusBar(),
        ),
        const SizedBox(height: 48),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '文章分类',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E2A38),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                final isSelected = selectedCategory == category || 
                    (selectedCategory == null && category == '全部');
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category == '全部' ? null : category;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFF6C5CE7).withOpacity(0.2),
                    checkmarkColor: const Color(0xFF6C5CE7),
                    labelStyle: TextStyle(
                      color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF666666),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyGrowthEntry() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🌱 今日成长仪式',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '记录今天的学习与成长',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => RouteManager.navigateWithAnimation(context, AppRoutes.dailyGrowth),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C5CE7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('开始打�?),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.auto_awesome,
            size: 48,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }

  Widget _buildLatestPosts() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '最新文�?,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E2A38),
            ),
          ),
          const SizedBox(height: 16),
          Consumer<BlogModel>(
            builder: (context, blogModel, child) {
              var posts = blogModel.publishedPosts;
              
              if (selectedCategory != null) {
                posts = posts.where((post) => post.category == selectedCategory).toList();
              }

              if (posts.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '暂无文章，开始写作吧�?,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: posts.take(6).map((post) => PostCard(post: post)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

