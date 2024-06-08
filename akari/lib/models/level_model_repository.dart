// level_model_repository.dart

import 'level_model.dart';

abstract class LevelModelRepository {
  Future<int> insertLevel(LevelModel level);
  Future<List<LevelModel>> getAllLevels();
  Future<LevelModel?> getLevelById(int id);
  Future<List<LevelModel>> getLevelsByLevel(String level);
  Future<LevelModel?> getLevelByLevelAndGameNo(String level, int gameNo); // New method
  Future<int> updateLevel(LevelModel level);
  Future<int> deleteLevel(int id);
}
