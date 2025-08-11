extension StringX on String? {
  String capitalizeFirstLetter() {
    if (this == null || this!.isEmpty) return '';
    return this![0].toUpperCase() + this!.substring(1);
  }

  String capitalizeWords() {
    if (this == null || this!.isEmpty) return '';
    return this!.split(' ').map((v) => v.capitalizeFirstLetter()).join(' ');
  }

  bool isNullOrBlank() {
    return this == null || this?.trim().isEmpty == true;
  }

  bool isUrl() {
    return this != null && this?.startsWith('http') == true;
  }

  String urlToName() {
    if (this == null || this!.isEmpty) return '';
    return this!
        .replaceAll('-', ' ')
        .replaceAll('_', ' ')
        .split(' ')
        .map((s) => s.capitalizeFirstLetter())
        .join(' ');
  }

  String? concat(String other) {
    if (this == null) return null;
    return '$this$other';
  }
}
