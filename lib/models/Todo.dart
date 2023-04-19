class Todo {
  String id;
  String title;
  String description;
  String date;
  // status
  // 0 - not started
  // 1 - completed
  // 2 - archive
  int status;

  Todo(
      {required this.id,
      this.title = '',
      this.description = '',
      this.date = '',
      this.status = 0});
}
