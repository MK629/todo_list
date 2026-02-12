class TodoItem {
  late int? id;
  late String description;
  late bool done;

  TodoItem({this.id, required this.description, required this.done});

  factory TodoItem.makeInsertReadyObject(String description){
    return TodoItem(description: description, done: false);
  }

  factory TodoItem.makeObjectFromMap(Map<String, Object?> mapFromDb){
    return TodoItem(id: mapFromDb['id'] as int, description: mapFromDb['description'] as String, done: mapFromDb['done'] as bool);
  }

  Map<String, Object?> toInsertMap(){
    return {
      "description" : description, 
      "done" : done
    };
  }

  Map<String, Object?> toUpdateMap(){
    if(id == null){
      throw Exception("Id is null. Cannot form map to update in database.");
    }

    return {
      "id" : id,
      "description" : description, 
      "done" : done
    };
  }

  void changeDescription(String newDescription){
    description = newDescription;
  }

  void changeStatus(bool newStatus){
    done = newStatus;
  }

  @override
  String toString() {
    return "id: $id, description: $description, done: $done";
  }
}