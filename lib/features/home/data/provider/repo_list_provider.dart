import 'package:etiqa_github_repo/features/home/domain/repository.dart';
import 'package:etiqa_github_repo/services/github_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repoListProvider =
    StateNotifierProvider<RepoListNotifier, AsyncValue<List<Repository>>>(
        (ref) {
  return RepoListNotifier(ref);
});

class RepoListNotifier extends StateNotifier<AsyncValue<List<Repository>>> {
  final Ref ref;

  RepoListNotifier(this.ref) : super(const AsyncValue.loading());

  // To keep track of current page
  int _currentPage = 1;

  Future<void> fetchRepos({bool isRetry = false}) async {
    try {
      final repos =
          await ref.read(githubApiServiceProvider).fetchRepos(_currentPage);
      state = AsyncValue.data([...state.value ?? [], ...repos]);
      _currentPage++;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final githubApiServiceProvider = Provider((ref) => GithubApiService());
