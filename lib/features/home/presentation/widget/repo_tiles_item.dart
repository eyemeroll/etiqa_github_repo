import 'package:etiqa_github_repo/features/home/domain/repository.dart';
import 'package:etiqa_github_repo/utils/formatter.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(repo.description.isEmpty ? '-' : repo.description),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        repo.ownerAvatarUrl,
                        width: 30,
                      )),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(repo.owner)
                ],
              ),
              Text(' ★ ${formatNumber(repo.stars)}'),
            ],
          ),
        ],
      ),
    );
  }
}
