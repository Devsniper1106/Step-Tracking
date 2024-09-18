DateTime getLocalToday() {
  DateTime now = DateTime.now().toLocal();
  return DateTime(now.year, now.month, now.day);
}

String getDailyCollectionName() {
  DateTime now = DateTime.now().toLocal();
  return "${now.year}-${now.month}-${now.day}";
}
