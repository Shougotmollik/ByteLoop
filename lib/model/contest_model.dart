class ContestModel {
  final int id;
  final String name;
  final String type;
  final String phase;
  final int startTimeSeconds;
  final int durationSeconds;

  ContestModel({
    required this.id,
    required this.name,
    required this.type,
    required this.phase,
    required this.startTimeSeconds,
    required this.durationSeconds,
  });

  factory ContestModel.fromJson(Map<String, dynamic> json) {
    return ContestModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      phase: json['phase'] ?? '',
      startTimeSeconds: json['startTimeSeconds'] ?? 0,
      durationSeconds: json['durationSeconds'] ?? 0,
    );
  }

  // Contest URL
  String get url => "https://codeforces.com/contest/$id";

  // Contest Logo (for now only Codeforces)
  String get iconLogo =>
      "https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fcer3l19eex0wy900b101.jpg";

  String get logo =>
      "https://sta.codeforces.com/s/95630/images/codeforces-logo-with-telegram.png";
}
