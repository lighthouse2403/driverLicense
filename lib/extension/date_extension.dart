extension DateTimeExtension on DateTime {
  String generateDurationTime() {
    Duration duration = DateTime.now().difference(this);

    String durationString = '';
    int months = duration.inDays ~/ 30;
    int year = months ~/ 12;
    String unit = '';

    if (year > 0) {
      durationString = '$year';
      unit = 'năm';
    } else if (months > 0) {
      durationString = '$months';
      unit = 'tháng';
    } else if (duration.inDays > 0) {
      durationString = '${duration.inDays}';
      unit = 'ngày';
    } else if (duration.inHours > 0) {
      durationString = '${duration.inHours}';
      unit = 'giờ';
    } else if (duration.inMinutes > 0) {
      durationString = '${duration.inMinutes}';
      unit = 'phút';
    } else {
      durationString = 'Bây giờ';
    }
    return '$durationString $unit';
  }
}