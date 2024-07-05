class Post {
  final String id;
  final String title;
  final String content;
  final String thumbnail;
  final String author;
  final String category;
  final DateTime createdAt;
  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.thumbnail,
    required this.author,
    required this.category,
    required this.createdAt,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      thumbnail: map['thumbnail'] as String,
      author: map['author'] as String,
      category: map['category'] as String,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
