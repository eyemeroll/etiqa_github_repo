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

  bool _isLoading = false;
  bool _isLoadingMore = false;

  bool get isLoadingMore => _isLoadingMore;

  void resetPagination() {
    _currentPage = 1;
  }

  Future<void> fetchRepos({bool isRetry = false}) async {

    if (_isLoading) return;
    _isLoading = true;

    // If user encountered any error during loading github repo
    // We want to allow user to click a button, and retry again
    // This is a mechanism to refresh the UI 
    if (isRetry) {
      state = const AsyncValue.loading();
    } else if (_currentPage > 1) {
      _isLoadingMore = true;
      state = AsyncValue.data([...state.value ?? []]);
    }

    try {
      final repos =
          await ref.read(githubApiServiceProvider).fetchRepos(_currentPage);
      state = AsyncValue.data([...state.value ?? [], ...repos]);
      _currentPage++;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      _isLoading = false;
      _isLoadingMore = false;
    }
  }
}

final githubApiServiceProvider = Provider((ref) => GithubApiService());
