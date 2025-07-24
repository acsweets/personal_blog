import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/blog_model.dart';

class WowMomentsScreen extends StatefulWidget {
  const WowMomentsScreen({super.key});

  @override
  State<WowMomentsScreen> createState() => _WowMomentsScreenState();
}

class _WowMomentsScreenState extends State<WowMomentsScreen> {
  String _selectedCategory = '全部';
  final List<String> _categories = ['全部', '技术惊喜', '自然感动', '社会观察', '他人视角'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Text(
                '哇因子观察库',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('记录哇因子'),
                onPressed: _showAddWowMomentDialog,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Text('分类: '),
              DropdownButton<String>(
                value: _selectedCategory,
                items: _categories.map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                )).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value!),
              ),
            ],
          ),
        ),
        Consumer<BlogModel>(
          builder: (context, blogModel, child) {
            var moments = blogModel.wowMoments;
            
            if (_selectedCategory != '全部') {
              moments = moments.where((m) => m.category == _selectedCategory).toList();
            }

            if (moments.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(48.0),
                child: Column(
                  children: [
                    Icon(Icons.star_outline, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('还没有记录哇因子，开始记录吧！'),
                  ],
                ),
              );
            }

            return Column(
              children: moments.map((moment) => Card(
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              moment.category,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            DateFormat('yyyy-MM-dd').format(moment.date),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        moment.content,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (moment.keywords.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4,
                          children: moment.keywords.map((keyword) => Chip(
                            label: Text(keyword),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          )).toList(),
                        ),
                      ],
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

  void _showAddWowMomentDialog() {
    final contentController = TextEditingController();
    final keywordsController = TextEditingController();
    String selectedCategory = '技术惊喜';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('记录哇因子'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(labelText: '分类'),
                items: _categories.skip(1).map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                )).toList(),
                onChanged: (value) => setState(() => selectedCategory = value!),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: '内容'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: keywordsController,
                decoration: const InputDecoration(labelText: '关键词(用逗号分隔)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                if (contentController.text.isNotEmpty) {
                  final blogModel = Provider.of<BlogModel>(context, listen: false);
                  final keywords = keywordsController.text
                      .split(',')
                      .map((k) => k.trim())
                      .where((k) => k.isNotEmpty)
                      .toList();

                  final moment = WowMoment(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    content: contentController.text,
                    date: DateTime.now(),
                    category: selectedCategory,
                    keywords: keywords,
                  );

                  blogModel.addWowMoment(moment);
                  Navigator.pop(context);
                }
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
