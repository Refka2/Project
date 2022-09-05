
class TaskModel {

  TaskModel({
    this.taskId,
    this.userId,
    this.title,
    this.description,
    this.date,
    this.time,
    this.alarm,
    this.folder,
    this.favourite,
  });
  final String? taskId;
  final String? userId;
  final String? title;
  final String? description;
  final DateTime? date;
  final String? time;
  final bool? alarm;
  final String? folder;
  final bool? favourite;

  static TaskModel fromFirestore(Map<String, dynamic>? data) =>
      TaskModel(
        taskId: data?['taskId'],
        userId: data?['userId'],
        title: data?['title'],
        description: data?['description'],
        date: data?['date'].toDate(),
        time: data?['time'],
        alarm: data?['alarm'],
        folder: data?['folder'],
          favourite: data?['favourite'],
      );

  Map<String, dynamic> toFirestore() {
    return {
      'taskId': taskId,
      'userId': userId,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'alarm': alarm,
      'folder': folder,
      'favourite': favourite,
    };
  }
}
