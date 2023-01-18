extension StringExtensions on String? {
  String? firstCapitalize() {
    if (this != null) {
      if (this!.length > 1) {
        String newText = this![0].toUpperCase();
        newText += this!.substring(1);
        return newText;
      }
    }

    return this;
  }
}
