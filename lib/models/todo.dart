class Todo {
  String title;
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });

  // Add this for storing it as JSON in localStorage
  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        title: json['title'],
        isCompleted: json['isCompleted'],
      );
}
