import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/app_routes.dart';
import '../models/blog_model.dart';
import '../utils/route_manager.dart';

class CustomNavigationBar extends StatefulWidget {
  final String currentRoute;
  
  const CustomNavigationBar({super.key, this.currentRoute = '/'});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool isDarkMode = false;
  final ScrollController _scrollController = ScrollController();
  bool _showShadow = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showShadow = _scrollController.offset > 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode 
              ? [const Color(0xFF1A1C22), const Color(0xFF2B2F3A)]
              : [const Color(0xFF1E2A38), const Color(0xFF2D3748)],
        ),
        boxShadow: _showShadow ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Row(
            children: [
              _buildLogo(),
              const SizedBox(width: 48),
              Expanded(child: _buildNavItems()),
              _buildRightTools(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return InkWell(
      onTap: () => RouteManager.navigateWithAnimation(context, AppRoutes.home),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🪐 重拾 · 小宇宙',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  '探索欲与创造力的星系笔记',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItems() {
    final navItems = [
      NavItemData('首页', AppRoutes.home, Icons.home_outlined),
      NavItemData('仪式', AppRoutes.dailyGrowth, Icons.auto_awesome_outlined),
      NavItemData('哇因子', AppRoutes.wowMoments, Icons.star_outline),
      NavItemData('卡片', AppRoutes.techCards, Icons.library_books_outlined),
      NavItemData('实验室', AppRoutes.lab, Icons.science_outlined),
      NavItemData('关于', AppRoutes.about, Icons.person_outline),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: navItems.map((item) => _NavItem(
        data: item,
        isActive: widget.currentRoute == item.route,
        onTap: () => RouteManager.navigateWithAnimation(context, item.route),
      )).toList(),
    );
  }

  Widget _buildRightTools() {
    return Row(
      children: [
        _buildStatusBadge(),
        const SizedBox(width: 16),
        _ToolButton(
          icon: Icons.search,
          tooltip: '搜索',
          onTap: () => RouteManager.navigateWithAnimation(context, AppRoutes.search),
        ),
        const SizedBox(width: 8),
        _ToolButton(
          icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
          tooltip: isDarkMode ? '亮色模式' : '暗色模式',
          onTap: () => setState(() => isDarkMode = !isDarkMode),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Consumer<BlogModel>(
      builder: (context, blogModel, child) {
        
        final status = _getTodayStatus();
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Today: ',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 11,
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getTodayStatus() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) return '晨光初现 🌅';
    if (hour >= 12 && hour < 18) return '专注工作 ☀️';
    if (hour >= 18 && hour < 22) return '黄昏思考🌆';
    return '深夜探索 🌌';
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class NavItemData {
  final String title;
  final String route;
  final IconData icon;
  
  NavItemData(this.title, this.route, this.icon);
}

class _NavItem extends StatefulWidget {
  final NavItemData data;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.data,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          _controller.forward();
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          _controller.reverse();
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: widget.isActive ? Border(
                      bottom: BorderSide(
                        color: const Color(0xFFA29BFE),
                        width: 2,
                      ),
                    ) : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.data.icon,
                        size: 18,
                        color: widget.isActive 
                            ? const Color(0xFFA29BFE)
                            : _isHovered 
                                ? Colors.white
                                : Colors.white70,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.data.title,
                        style: TextStyle(
                          color: widget.isActive 
                              ? const Color(0xFFA29BFE)
                              : _isHovered 
                                  ? Colors.white
                                  : Colors.white70,
                          fontSize: 12,
                          fontWeight: widget.isActive 
                              ? FontWeight.w600 
                              : FontWeight.normal,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ToolButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _ToolButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_ToolButton> createState() => _ToolButtonState();
}

class _ToolButtonState extends State<_ToolButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isHovered 
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              widget.icon,
              size: 20,
              color: _isHovered ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
