class Category {
  final int id;
  final int pid;
  final String name;
  final String slug;
  final String icon;
  final String image;

  Category({
    required this.id,
    required this.pid,
    required this.name,
    required this.slug,
    required this.icon,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      pid: json['parent_id'],
      name: json['name'],
      slug: json['slug'],
      icon: json['icon'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
      };
}
