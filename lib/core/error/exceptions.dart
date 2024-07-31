class FileNotFoundException implements Exception {
  final String message;

  FileNotFoundException({required this.message});
}

class InvalidFormatException implements Exception {
  final String message;

  InvalidFormatException({required this.message});
}

class UnknownException implements Exception {
  final String message;

  UnknownException({required this.message});
}
