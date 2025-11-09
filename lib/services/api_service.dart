import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class ApiService {
  static const String baseUrl = 'https://openlibrary.org/search.json';

  // Método para buscar livros pela API
  Future<List<Book>> searchBooks(String query) async {
    try {
      // Monta a URL com o termo de busca
      final url = Uri.parse('$baseUrl?q=$query');

      // Faz a requisição GET
      final response = await http.get(url);

      // Verifica se a requisição foi bem-sucedida
      if (response.statusCode == 200) {
        // Decodifica o JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Extrai a lista de documentos (livros)
        final List<dynamic> docs = data['docs'] ?? [];

        // Converte cada item em um objeto Book
        return docs.map((json) => Book.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar livros: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}
