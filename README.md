# 个人博客

这是一个使用Flutter构建的个人博客项目，部署在GitHub Pages上。

## 功能特性

- 响应式设计，支持多种设备
- 简洁的博客文章展示
- 自动化部署到GitHub Pages

## 本地开发

1. 确保已安装Flutter SDK
2. 克隆项目到本地
3. 运行以下命令：

```bash
flutter pub get
flutter run -d chrome
```

## 部署

项目配置了GitHub Actions自动部署，当推送到main分支时会自动构建并部署到GitHub Pages。

## 项目结构

```
lib/
├── main.dart          # 应用入口
└── screens/
    └── home_screen.dart   # 主页面
```

## 技术栈

- Flutter
- Dart
- GitHub Actions
- GitHub Pages