# 个人博客项目文档

## 项目概述

**项目名称**: 重拾 · 小宇宙  
**技术栈**: Flutter + Dart  
**部署平台**: GitHub Pages  
**版本**: 1.0.0+1

这是一个使用Flutter构建的现代化个人博客应用，专注于记录学习成长、技术心得和生活感悟。项目采用响应式设计，支持多平台部署，并通过GitHub Actions实现自动化部署。

## 核心功能特性

### 📝 博客系统
- **文章管理**: 支持创建、编辑、删除博客文章
- **分类筛选**: 按技术、思维、成长、英语、情绪等分类组织内容
- **标签系统**: 灵活的标签管理和筛选功能
- **草稿功能**: 支持文章草稿保存和发布
- **Markdown支持**: 使用flutter_markdown渲染文章内容

### 🌟 哇因子记录
- 记录日常生活中的精彩瞬间和感悟
- 按类别组织哇因子内容
- 关键词标记功能

### 📈 每日成长打卡
- **学习记录**: 每日技术学习卡片
- **英语学习**: 每日英语句子积累
- **反思总结**: 每日成长反思记录
- **公开分享**: 可选择性公开成长记录

### 🔍 搜索功能
- 全文搜索博客文章
- 按标题、内容、标签搜索
- 实时搜索结果展示

### 🎨 用户体验
- **响应式设计**: 适配桌面、平板、手机等多种设备
- **主题系统**: 支持明暗主题切换
- **动画效果**: 流畅的页面切换和交互动画
- **现代化UI**: 采用Material Design 3设计规范

## 项目架构

### 目录结构
```
lib/
├── main.dart                 # 应用入口
├── animations/               # 动画效果
│   └── page_transitions.dart
├── data/                     # 数据层
│   └── sample_data.dart
├── models/                   # 数据模型
│   └── blog_model.dart
├── routes/                   # 路由配置
│   └── app_routes.dart
├── screens/                  # 页面组件
│   ├── home_screen.dart      # 首页
│   ├── write_screen.dart     # 写作页面
│   ├── wow_moments_screen.dart # 哇因子页面
│   ├── daily_growth_screen.dart # 每日成长页面
│   ├── tech_cards_screen.dart # 技术卡片页面
│   ├── search_screen.dart    # 搜索页面
│   ├── lab_screen.dart       # 实验室页面
│   └── about_screen.dart     # 关于页面
├── theme/                    # 主题配置
│   └── app_theme.dart
├── utils/                    # 工具类
│   └── route_manager.dart
└── widgets/                  # 通用组件
    ├── footer.dart           # 页脚组件
    ├── hero_banner.dart      # 英雄横幅
    ├── main_layout.dart      # 主布局
    ├── navigation_bar.dart   # 导航栏
    ├── post_card.dart        # 文章卡片
    ├── status_bar.dart       # 状态栏
    ├── tag_filter.dart       # 标签筛选
    └── wow_moment_carousel.dart # 哇因子轮播
```

### 核心架构模式

#### 1. 状态管理
- 使用 **Provider** 进行状态管理
- `BlogModel` 作为主要的数据模型，管理博客文章、哇因子、每日成长等数据
- 采用 `ChangeNotifier` 实现响应式数据更新

#### 2. 路由管理
- 使用 `RouteManager` 统一管理路由跳转
- 支持自定义页面切换动画
- 路由配置集中在 `AppRoutes` 类中

#### 3. 主题系统
- 支持明暗两套主题
- 使用 Material Design 3 设计规范
- 自定义颜色配色方案

## 数据模型

### BlogPost (博客文章)
```dart
class BlogPost {
  final String id;           // 唯一标识
  final String title;        // 文章标题
  final String content;      // 文章内容(Markdown)
  final DateTime createdAt;  // 创建时间
  final DateTime updatedAt;  // 更新时间
  final List<String> tags;   // 标签列表
  final String category;     // 分类
  final bool isDraft;        // 是否为草稿
  final String summary;      // 文章摘要
}
```

### WowMoment (哇因子)
```dart
class WowMoment {
  final String id;           // 唯一标识
  final String content;      // 内容描述
  final DateTime date;       // 记录日期
  final String category;     // 分类
  final List<String> keywords; // 关键词
}
```

### DailyGrowth (每日成长)
```dart
class DailyGrowth {
  final String id;           // 唯一标识
  final DateTime date;       // 日期
  final String wowMoment;    // 哇因子
  final String englishSentence; // 英语句子
  final String techCard;     // 技术卡片
  final String reflection;   // 反思总结
  final bool isPublic;       // 是否公开
}
```

## 技术特性

### 依赖包
- **flutter**: Flutter SDK
- **provider**: 状态管理
- **shared_preferences**: 本地存储
- **flutter_markdown**: Markdown渲染
- **intl**: 国际化支持
- **url_launcher**: URL启动
- **path_provider**: 路径获取
- **uuid**: UUID生成
- **cupertino_icons**: iOS风格图标

### 主题配色
- **主色调**: 星空色 (#1E2A38)
- **强调色**: 紫光渐变 (#6C5CE7 → #A29BFE)
- **背景色**: 象牙色 (#F9F9F9)
- **卡片背景**: 微米色 (#F7F8FA)
- **成长色**: 萌芽绿 (#00B894)
- **暮光色**: 暮光橙 (#FAB1A0)

### 响应式设计
- 支持桌面、平板、手机多种屏幕尺寸
- 自适应布局和组件大小
- 触摸友好的交互设计

## 部署配置

### GitHub Actions 自动部署
项目配置了完整的CI/CD流程：

```yaml
name: Deploy to GitHub Pages
on:
  push:
    branches: [ main ]
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
    - name: Setup Flutter (3.27.4)
    - name: Install dependencies
    - name: Build web
    - name: Deploy to GitHub Pages
```

### 构建配置
- Flutter版本: 3.27.4 (stable)
- 构建目标: Web平台
- 基础路径: `/personal_blog/`
- 部署平台: GitHub Pages

## 开发指南

### 本地开发环境
1. 安装Flutter SDK (3.5.0+)
2. 克隆项目到本地
3. 安装依赖: `flutter pub get`
4. 运行项目: `flutter run -d chrome`

### 代码规范
- 使用 `flutter_lints` 进行代码检查
- 遵循Dart官方代码规范
- 组件命名采用PascalCase
- 文件命名采用snake_case

### 添加新功能
1. 在对应目录创建新文件
2. 更新路由配置 (如需要)
3. 更新数据模型 (如需要)
4. 测试功能完整性

## 未来规划

### 待开发功能
- [ ] 技术卡片管理系统
- [ ] 文章评论功能
- [ ] 数据导出功能
- [ ] 多语言支持
- [ ] 离线阅读功能
- [ ] 文章分享功能

### 性能优化
- [ ] 图片懒加载
- [ ] 文章分页加载
- [ ] 缓存优化
- [ ] 包大小优化

### 用户体验改进
- [ ] 更丰富的动画效果
- [ ] 自定义主题色彩
- [ ] 阅读进度指示
- [ ] 快捷键支持

## 项目亮点

1. **现代化设计**: 采用Material Design 3，界面简洁美观
2. **完整的功能体系**: 不仅是博客，还包含成长记录、学习打卡等功能
3. **响应式布局**: 完美适配各种设备屏幕
4. **自动化部署**: GitHub Actions实现一键部署
5. **可扩展架构**: 清晰的代码结构，便于功能扩展
6. **用户体验优先**: 流畅的动画和交互设计

## 联系信息

如有问题或建议，欢迎通过以下方式联系：
- GitHub Issues
- 项目讨论区

---

*最后更新时间: 2024年12月*