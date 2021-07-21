class Images {
  Images({
    required this.thumb,
    required this.preview,
    required this.original,
  });

  String thumb;
  String preview;
  String original;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        thumb: json["thumb"],
        preview: json["preview"],
        original: json["original"],
      );

  Map<String, dynamic> toJson() => {
        "thumb": thumb,
        "preview": preview,
        "original": original,
      };
}
