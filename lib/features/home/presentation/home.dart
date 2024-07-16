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

  @override
  Widget build(BuildContext context) {
    final repoListState = ref.watch(repoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Repos'),
      ),
      body: repoListState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (repoList) => NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              ref.read(repoListProvider.notifier).fetchRepos();
            }
            return false;
          },
          child: ListView.separated(
            separatorBuilder: (c,i){
              return const Divider(thickness: 0.5,);
            },
            itemCount: repoList.length,
            itemBuilder: (context, index) {
              final repo = repoList[index];
              return RepoTilesItem(repo: repo);
            },
          ),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
