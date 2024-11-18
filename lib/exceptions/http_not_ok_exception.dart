class HttpNotOkException implements Exception {
  final int statusCode;
  final String message;

  HttpNotOkException(this.statusCode, [this.message = '']);

  @override
  String toString() {
    if (message.isEmpty) {
      return 'Fehlerhafte Antwort vom Server: $statusCode';
    }
    return 'Fehlerhafte Antwort vom Server: $statusCode - $message';
  }
}
