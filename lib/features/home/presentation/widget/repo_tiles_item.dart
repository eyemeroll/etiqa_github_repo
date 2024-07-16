import 'package:etiqa_github_repo/features/home/domain/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepoTilesItem extends ConsumerWidget {
  final Repository repo;
  const RepoTilesItem({super.key, required this.repo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        repo.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(repo.description),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    repo.ownerAvatarUrl,
                    width: 30,
                  )),
              Text(' ★ ${repo.stars}'),
            ],
          ),
        ],
      ),
    );
  }
}
