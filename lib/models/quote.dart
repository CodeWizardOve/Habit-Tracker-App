class Quote {
  final String text;
  final String author;

  Quote({
    required this.text,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['content'] ?? json['text'] ?? '',
      author: json['author'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'author': author,
    };
  }
}
