class ServerException implements Exception {}

class CacheException implements Exception {}

class ConflictException implements Exception {}

class NotAcceptableException implements Exception {}

Exception mapResponseException(int statusCode) {
  switch (statusCode) {
    case 409:
      return ConflictException();
    case 406:
      return NotAcceptableException();
    default:
      return ServerException();
  }
}
