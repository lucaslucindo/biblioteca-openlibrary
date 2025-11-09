import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../services/api_service.dart';

class BookProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Book> _books = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters para acessar os dados
  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Método para buscar livros
  Future<void> searchBooks(String query) async {
    if (query.trim().isEmpty) {
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners(); // Notifica os widgets que estão ouvindo

    try {
      _books = await _apiService.searchBooks(query);

      if (_books.isEmpty) {
        _errorMessage = 'Nenhum livro encontrado';
      }
    } catch (e) {
      _errorMessage = 'Erro ao buscar livros: $e';
      _books = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifica novamente após carregar
    }
  }

  // Método para limpar a busca
  void clearSearch() {
    _books = [];
    _errorMessage = '';
    notifyListeners();
  }
}
