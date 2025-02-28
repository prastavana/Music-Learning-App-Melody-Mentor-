class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";
  // For iPhone
  // static const String baseUrl = "http://localhost:3000/api/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getAllStudent = "auth/getAllStudents";
  static const String updateStudent = "auth/updateStudent/";
  static const String deleteStudent = "auth/deleteStudent/";
  static const String imageUrl =
      "http://10.0.2.2:3000/uploads/"; // Corrected line
  static const String uploadImage = "auth/uploadImage";

  // ====================== SOong Routes ======================
  static const String getAllSongs =
      "songs/getsongs"; // Route for fetching all songs
  static const String getSongById = "songs/"; // Route for fetching a song by ID
}
