import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: ListTile(
        onTap: () {
          // print('Clicked on ToDo Item');
          onToDoChanged(todo);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            color: tdBlack,
            fontSize: 16.0,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 35.0,
          width: 35.0,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              // print('Clicked on delete icon');
              onDeleteItem(todo.id);
            },
            icon: const Icon(Icons.delete),
            iconSize: 18.0,
            color: Colors.white,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
    );
  }
}
