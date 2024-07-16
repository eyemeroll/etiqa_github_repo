class Repository {
  final String name;
  final String description;
  final int stars;
  final String ownerAvatarUrl;

  Repository({
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerAvatarUrl,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'] ?? 0,
      description: json['description'] ?? '',
      stars: json['stargazers_count'] ?? 0,
      ownerAvatarUrl: json['owner']['avatar_url'] ?? '',
    );
  }
}
