class ServerException implements Exception {
  String errorMessage ;

  ServerException({required this.errorMessage});
}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}
