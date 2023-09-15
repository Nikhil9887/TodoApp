import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/widgets/todo_item.dart';
import 'package:todo/models/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  late List<ToDo> _foundToDo = [];

  @override
  void initState() {
    // TODO: implement initState
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50.0,
                          bottom: 20.0,
                        ),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      // const ToDoItem(),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleTodoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      margin: const EdgeInsets.only(
                          bottom: 20.0, right: 20.0, left: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: const InputDecoration(
                            hintText: 'Add a new todo item',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 20.0,
                      right: 20.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _addToDoItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        elevation: 10.0,
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(
        ToDo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: toDo),
      );
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((element) => element.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            color: Colors.black,
            Icons.search,
            size: 20.0,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20.0,
            minWidth: 25.0,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: tdBGColor,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30.0,
          ),
          // SizedBox(
          //   height: 40.0,
          //   width: 40.0,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(20.0),
          //     child: Image.asset('assets/images/avatar.jpeg'),
          //   ),
          // )
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpeg'),
          ),
        ],
      ),
    );
  }
}
