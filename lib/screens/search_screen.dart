import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample_app/models/article.dart';

Future<List<Article>> searchQiita(String keyWord) async {
  final uri = Uri.https('qiita.com', '/api/v2/items', {
    'query': 'title: $keyWord',
    'per_page': 10,
  });

  final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

  final http.Response res = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
  });

  if (res.statusCode == 200) {
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((dynamic json) => Article.fromJson(json)).toList();
  } else {
    return [];
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SerchScreenState();
}

class _SerchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qiita Seach"),
      ),
      body: Container(),
    );
  }
}
