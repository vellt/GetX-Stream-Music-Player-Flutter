extension durationExtensions on Duration {
  String get timeFormat {
    String minute = int.parse(
            this.toString().split('.').first.padLeft(8, "0").split(':')[1])
        .toString();
    String second =
        this.toString().split('.').first.padLeft(8, "0").split(':')[2];
    return ("$minute:$second");
  }
}
