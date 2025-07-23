import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/blog_model.dart';

class DailyGrowthScreen extends StatelessWidget {
  const DailyGrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Text(
                '每日成长仪式',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('记录成长'),
                onPressed: () => _showAddGrowthDialog(context),
              ),
            ],
          ),
        ),
        Consumer<BlogModel>(
          builder: (context, blogModel, child) {
            final growths = blogModel.dailyGrowths;

            if (growths.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(48.0),
                child: Column(
                  children: [
                    Icon(Icons.trending_up, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('开始记录每日成长吧！'),
                  ],
                ),
              );
            }

            return Column(
              children: growths.map((growth) => Card(
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat('yyyy-MM-dd').format(growth.date),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Icon(
                            growth.isPublic ? Icons.public : Icons.lock,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _GrowthSection(
                        title: '🌟 今日哇因子',
                        content: growth.wowMoment,
                      ),
                      _GrowthSection(
                        title: '🇬🇧 今日英文',
                        content: growth.englishSentence,
                      ),
                      _GrowthSection(
                        title: '💡 技术卡片',
                        content: growth.techCard,
                      ),
                      _GrowthSection(
                        title: '🤔 思维反思',
                        content: growth.reflection,
                      ),
                    ],
                  ),
                ),
              )).toList(),
            );
          },
        ),
      ],
    );
  }

  void _showAddGrowthDialog(BuildContext context) {
    final wowController = TextEditingController();
    final englishController = TextEditingController();
    final techController = TextEditingController();
    final reflectionController = TextEditingController();
    bool isPublic = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('记录今日成长'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: wowController,
                  decoration: const InputDecoration(labelText: '今日哇因子'),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: englishController,
                  decoration: const InputDecoration(labelText: '今日英文'),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: techController,
                  decoration: const InputDecoration(labelText: '技术卡片'),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: reflectionController,
                  decoration: const InputDecoration(labelText: '思维反思'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('公开显示'),
                  value: isPublic,
                  onChanged: (value) => setState(() => isPublic = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                final blogModel = Provider.of<BlogModel>(context, listen: false);
                final growth = DailyGrowth(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  date: DateTime.now(),
                  wowMoment: wowController.text,
                  englishSentence: englishController.text,
                  techCard: techController.text,
                  reflection: reflectionController.text,
                  isPublic: isPublic,
                );

                blogModel.addDailyGrowth(growth);
                Navigator.pop(context);
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}

class _GrowthSection extends StatelessWidget {
  final String title;
  final String content;

  const _GrowthSection({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}