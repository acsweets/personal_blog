import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class BlogPost {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final String category;
  final bool isDraft;
  final String summary;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.tags,
    required this.category,
    this.isDraft = false,
    this.summary = '',
  });

  BlogPost copyWith({
    String? title,
    String? content,
    List<String>? tags,
    String? category,
    bool? isDraft,
    String? summary,
  }) {
    return BlogPost(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      tags: tags ?? this.tags,
      category: category ?? this.category,
      isDraft: isDraft ?? this.isDraft,
      summary: summary ?? this.summary,
    );
  }
}

class WowMoment {
  final String id;
  final String content;
  final DateTime date;
  final String category;
  final List<String> keywords;

  WowMoment({
    required this.id,
    required this.content,
    required this.date,
    required this.category,
    this.keywords = const [],
  });
}

class DailyGrowth {
  final String id;
  final DateTime date;
  final String wowMoment;
  final String englishSentence;
  final String techCard;
  final String reflection;
  final bool isPublic;

  DailyGrowth({
    required this.id,
    required this.date,
    required this.wowMoment,
    required this.englishSentence,
    required this.techCard,
    required this.reflection,
    this.isPublic = true,
  });
}

class BlogModel extends ChangeNotifier {
  final List<BlogPost> _posts = [];
  final List<WowMoment> _wowMoments = [];
  final List<DailyGrowth> _dailyGrowths = [];
  final Uuid _uuid = const Uuid();

  List<BlogPost> get posts => List.unmodifiable(_posts);
  List<WowMoment> get wowMoments => List.unmodifiable(_wowMoments);
  List<DailyGrowth> get dailyGrowths => List.unmodifiable(_dailyGrowths);

  List<BlogPost> get publishedPosts => 
      _posts.where((post) => !post.isDraft).toList();

  List<String> get allTags {
    final tags = <String>{};
    for (final post in _posts) {
      tags.addAll(post.tags);
    }
    return tags.toList()..sort();
  }

  void addPost(BlogPost post) {
    _posts.insert(0, post);
    notifyListeners();
  }

  void updatePost(BlogPost updatedPost) {
    final index = _posts.indexWhere((post) => post.id == updatedPost.id);
    if (index != -1) {
      _posts[index] = updatedPost;
      notifyListeners();
    }
  }

  void deletePost(String id) {
    _posts.removeWhere((post) => post.id == id);
    notifyListeners();
  }

  BlogPost createNewPost({
    required String title,
    required String content,
    required List<String> tags,
    required String category,
    bool isDraft = false,
    String summary = '',
  }) {
    return BlogPost(
      id: _uuid.v4(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tags: tags,
      category: category,
      isDraft: isDraft,
      summary: summary,
    );
  }

  void addWowMoment(WowMoment moment) {
    _wowMoments.insert(0, moment);
    notifyListeners();
  }

  void addDailyGrowth(DailyGrowth growth) {
    _dailyGrowths.insert(0, growth);
    notifyListeners();
  }

  List<BlogPost> getPostsByTag(String tag) {
    return _posts.where((post) => post.tags.contains(tag)).toList();
  }

  List<BlogPost> searchPosts(String query) {
    return _posts.where((post) =>
        post.title.toLowerCase().contains(query.toLowerCase()) ||
        post.content.toLowerCase().contains(query.toLowerCase()) ||
        post.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()))
    ).toList();
  }
}