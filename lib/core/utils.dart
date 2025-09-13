String formatError(Object e) {
  String error = e.toString();
  if (error.startsWith("Exception:")) {
    return error.replaceFirst("Exception:", "").trim();
  }
  return error;
}

String formatDate(DateTime date) {
  return date.toLocal().toIso8601String().substring(0,10);
}
