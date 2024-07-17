import 'package:etiqa_github_repo/features/home/data/provider/repo_list_provider.dart';
import 'package:etiqa_github_repo/features/home/presentation/widget/repo_tiles_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(repoListProvider.notifier).fetchRepos());
  }

  Future<void> _refresh() async {
    // Reset pagination and fetch new data
    final notifier = ref.read(repoListProvider.notifier);
    notifier.resetPagination();
    await notifier.fetchRepos(isRetry: true);
  }

  @override
  Widget build(BuildContext context) {

    final repoListState = ref.watch(repoListProvider);
    final notifier = ref.read(repoListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Repos'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: repoListState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (repoList) => NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !notifier.isLoadingMore) {
                notifier.fetchRepos();
              }
              return false;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.separated(
                separatorBuilder: (c,i){
                  return const Divider(thickness: 0.5,);
                },
                itemCount: repoList.length + (notifier.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == repoList.length) {
                    return const Padding(
                      padding:  EdgeInsets.only(bottom: 16.0),
                      child:  Center(child: CircularProgressIndicator()),
                    );
                  }
                  final repo = repoList[index];
                  return RepoTilesItem(repo: repo);
                },
              ),
            ),
          ),
          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $err'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    notifier.fetchRepos(isRetry: true);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(Icons.home)),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Icon(Icons.settings))],),
      );
  }
}
