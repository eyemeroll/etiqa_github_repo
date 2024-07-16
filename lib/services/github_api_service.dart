import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:etiqa_github_repo/features/home/domain/repository.dart';

class GithubApiService {
  
  Future<List<Repository>> fetchRepos(int page) async {
    final date = DateTime.now().subtract(const Duration(days: 10)).toIso8601String().split('T').first;
    final response = await http.get(Uri.parse('https://api.github.com/search/repositories?q=created:>$date&sort=stars&order=desc&page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Repository> repos = (data['items'] as List)
          .map((item) => Repository.fromJson(item))
          .toList();
      return repos;
    } else {
      throw Exception('Failed to load repos');
    }
  }
}