class Book {
  final String title;
  final List<String> authors;
  final int? coverId;
  final String? firstPublishYear;

  Book({
    required this.title,
    required this.authors,
    this.coverId,
    this.firstPublishYear,
  });

  // Método factory para criar um objeto Book a partir do JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Título desconhecido',
      authors: json['author_name'] != null
          ? List<String>.from(json['author_name'])
          : ['Autor desconhecido'],
      coverId: json['cover_i'],
      firstPublishYear: json['first_publish_year']?.toString(),
    );
  }

  // Método para gerar a URL da capa do livro
  String? get coverUrl {
    if (coverId != null) {
      return 'https://covers.openlibrary.org/b/id/$coverId-M.jpg';
    }
    return null;
  }
}
