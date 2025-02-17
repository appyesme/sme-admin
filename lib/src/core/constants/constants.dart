const List<String> weekNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
const List<String> weekShortNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const Duration animDuration = Duration(milliseconds: 250);

List<DateTime> weekDates({DateTime? date}) {
  final selectedDay = date ?? DateTime.now();
  // Adjust the weekday so Sunday is 0 and Saturday is 6
  int weekday = selectedDay.weekday % 7; // This will make Sunday 0, Monday 1, ..., Saturday 6
  DateTime start = selectedDay.subtract(Duration(days: weekday)); // Get the Sunday of the current week
  return List.generate(7, (i) => start.add(Duration(days: i))); // Generate dates from Sunday to Saturday
}
