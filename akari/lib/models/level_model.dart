class LevelModel {
  int? id;
  late String level;
  late int gameNo;
  late int score;
  late bool status; // true for unlocked, false for locked

  LevelModel({
    this.id,
    required this.level,
    required this.gameNo,
    required this.score,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level': level,
      'gameNo': gameNo,
      'score': score,
      'status': status ? 1 : 0,
    };
  }

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'],
      level: json['level'],
      gameNo: json['gameNo'],
      score: json['score'],
      status: json['status'] == 1 ? true : false,
    );
  }
}
