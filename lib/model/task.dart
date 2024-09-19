//de el 7aga ely n3mlha 34an ndeef task
class Task {
  static const String collectionName = 'tasks';
  String id; // el unique ely ymyz el 7aga
  String title;
  String description;

  DateTime dateTime;

  bool isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.dateTime,
      required this.description,
      this.isDone = false}); //constructor 34an null safety

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'] as String,
            //optional,
            title: data['title'],
            description: data['description'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            isDone: data[
                'isDone']); //keda 74awr 3la 7aga , 7rg3 obj yb2a lazm 2nady 3la constructor

  /// json => obj  dh 34an na 2fhm
  /// obj => json dh 34an firebase yfhm
  Map<String, dynamic> toFireStore() {
    /// tofirestore obj => json

    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
