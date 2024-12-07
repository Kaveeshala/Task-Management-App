/*class Task{
  String title;
  bool complete;

  Task(this.title, this.complete);
}

*/

class Task {
  int? _id; // Nullable to support tasks before they are saved in the database
  late String _title;
  late bool _complete;

   // Default constructor
  Task(this._title, this._complete);

  // Named constructor with ID
  Task.withId(this._id, this._title, this._complete);


  // Getter for ID
  int? get id => _id;

  // Getter for Title
  String get title => _title;

  // Setter for Title
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  // Getter for Complete
  bool get complete => _complete;

  // Setter for Complete
  set complete(bool newComplete) {
    _complete = newComplete;
  }

  // Convert a Task object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['complete'] = _complete ? 1 : 0; // Store as integer (0 or 1)
    return map;
  }

  // Extract a Task object from a Map object
  Task.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _complete = map['complete'] == 1; // Convert integer back to bool
  }
}

