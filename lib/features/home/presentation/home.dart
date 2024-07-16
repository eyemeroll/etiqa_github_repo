import 'package:etiqa_github_repo/features/home/data/provider/repo_list_provider.dart';
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
        title: const Text('GitHub Repos'),
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
          child: ListView.builder(
            itemCount: repoList.length,
            itemBuilder: (context, index) {
              final repo = repoList[index];
              return ListTile(
                leading: Image.network(repo.ownerAvatarUrl),
                title: Text(repo.name),
                subtitle: Text(repo.description),
                trailing: Text('${repo.stars} ★'),
              );
            },
          ),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
