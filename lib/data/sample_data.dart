import '../models/blog_model.dart';

class SampleData {
  static void loadSampleData(BlogModel blogModel) {
    // 添加示例文章
    final samplePosts = [
      BlogPost(
        id: '1',
        title: 'Flutter开发心得：从零到一的学习之�?,
        content: '''# Flutter开发心�?
## 前言
最近开始学习Flutter，记录一下学习过程中的心得体会�?
## 学习要点
1. Dart语言基础
2. Widget系统理解
3. 状态管�?4. 布局系统

## 总结
Flutter确实是一个很棒的跨平台框架，值得深入学习�?''',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        tags: ['Flutter', 'Dart', '移动开�?],
        category: '技�?,
        summary: '记录Flutter学习过程中的心得体会，包括Dart语言基础、Widget系统等核心概念�?,
      ),
      BlogPost(
        id: '2',
        title: '重新思考学习的意义',
        content: '''# 重新思考学习的意义

## 为什么要学习�?学习不仅仅是为了获得知识，更是为了培养思维能力�?
## 学习的乐�?- 探索未知的兴�?- 解决问题的成就感
- 连接知识点的顿悟

## 持续学习的动�?保持好奇心，享受学习的过程�?''',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
        tags: ['学习', '思维', '成长'],
        category: '思维',
        summary: '重新审视学习的本质意义，探讨如何保持学习的内在动力�?,
      ),
    ];

    for (final post in samplePosts) {
      blogModel.addPost(post);
    }

    // 添加示例哇因�?    final sampleWowMoments = [
      WowMoment(
        id: '1',
        content: '今天看到一只蝴蝶在花丛中翩翩起舞，突然意识到生命的美好就在这些微小的瞬间里�?,
        date: DateTime.now(),
        category: '自然感动',
        keywords: ['蝴蝶', '生命', '美好'],
      ),
      WowMoment(
        id: '2',
        content: '解决了一个困扰很久的编程问题，那种豁然开朗的感觉真是太棒了！',
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: '技术惊�?,
        keywords: ['编程', '解决问题', '成就�?],
      ),
    ];

    for (final moment in sampleWowMoments) {
      blogModel.addWowMoment(moment);
    }

    // 添加示例每日成长
    final sampleGrowths = [
      DailyGrowth(
        id: '1',
        date: DateTime.now(),
        wowMoment: '发现了一个很有趣的Flutter动画效果',
        englishSentence: 'The journey of a thousand miles begins with one step.',
        techCard: 'Flutter AnimationController的使用方�?,
        reflection: '今天学习效率很高，要保持这种状�?,
        isPublic: true,
      ),
    ];

    for (final growth in sampleGrowths) {
      blogModel.addDailyGrowth(growth);
    }
  }
}
