import 'package:flutter/material.dart';

class TechCardsScreen extends StatelessWidget {
  const TechCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Text(
                '技术卡片集',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('添加卡片'),
                onPressed: () {
                  // TODO: 添加技术卡片功能
                },
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(48.0),
          child: Column(
            children: [
              Icon(Icons.library_books, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('技术卡片功能开发中...'),
            ],
          ),
        ),
      ],
    );
  }
}
