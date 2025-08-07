abstract class DSCRepository {
  Future<String> detectToken();
  Future<String> signFile(String filePath);
}
