import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/blog_model.dart';

class TagFilter extends StatelessWidget {
  final String? selectedTag;
  final Function(String?) onTagSelected;

  const TagFilter({
    super.key,
    required this.selectedTag,
    required this.onTagSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogModel>(
      builder: (context, blogModel, child) {
        final tags = blogModel.allTags;
        
        if (tags.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('标签筛�?, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                FilterChip(
                  label: const Text('全部'),
                  selected: selectedTag == null,
                  onSelected: (selected) => onTagSelected(null),
                ),
                ...tags.map((tag) => FilterChip(
                  label: Text(tag),
                  selected: selectedTag == tag,
                  onSelected: (selected) => onTagSelected(selected ? tag : null),
                )),
              ],
            ),
          ],
        );
      },
    );
  }
}
