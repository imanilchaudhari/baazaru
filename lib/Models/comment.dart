class Comment {
  final int id;
  final int pid;
  final int parent;
  final String author;
  final String email;
  final String content;

  Comment({
    this.id,
    this.pid,
    this.parent,
    this.author,
    this.email,
    this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      pid: json['product_id'],
      parent: json['parent'],
      author: json['author'],
      email: json['email'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() => {
        'author': author,
        'email': email,
      };
}
