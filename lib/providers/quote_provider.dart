import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteProvider extends ChangeNotifier {
  List<Quote> _quotes = [];
  bool _isLoading = false;
  String? _error;
  final Random _random = Random();

  List<Quote> get quotes => _quotes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fallback quotes in case the API is unavailable
  static const List<Map<String, String>> _fallbackQuotes = [
    {
      "text": "Success is not final, failure is not fatal: it is the courage to continue that counts.",
      "author": "Winston Churchill"
    },
    {
      "text": "It does not matter how slowly you go as long as you do not stop.",
      "author": "Confucius"
    },
    {
      "text": "The only way to do great work is to love what you do.",
      "author": "Steve Jobs"
    },
    {
      "text": "What you get by achieving your goals is not as important as what you become by achieving your goals.",
      "author": "Zig Ziglar"
    },
    {
      "text": "Success is walking from failure to failure with no loss of enthusiasm.",
      "author": "Winston Churchill"
    },
    {
      "text": "The future depends on what you do today.",
      "author": "Mahatma Gandhi"
    },
    {
      "text": "The only limit to our realization of tomorrow will be our doubts of today.",
      "author": "Franklin D. Roosevelt"
    }
  ];

  // Using the Quotable API
  static const String _baseUrl = 'https://api.quotable.io';

  Future<void> fetchQuotes({int count = 5}) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await http.get(
        Uri.parse('$_baseUrl/quotes/random?limit=$count'),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException('Request timed out'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _quotes = data.map((json) => Quote.fromJson(json)).toList();
      } else {
        throw HttpException('Failed to load quotes');
      }
    } catch (e) {
      // Use fallback quotes if API fails
      _quotes = _getRandomFallbackQuotes(count);
      _error = null; // Clear error since we're using fallback quotes
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Quote> _getRandomFallbackQuotes(int count) {
    final quotes = List<Map<String, String>>.from(_fallbackQuotes);
    quotes.shuffle(_random);
    return quotes
        .take(min(count, quotes.length))
        .map((q) => Quote(text: q['text']!, author: q['author']!))
        .toList();
  }

  Future<void> refreshQuotes() async {
    await fetchQuotes();
  }
}
