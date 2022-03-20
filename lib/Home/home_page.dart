// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:listtodo/model/list.dart';
import 'dart:convert';

import '../api/api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Task> taskList = <Task>[];

  void getTaskFromAPI() async {
    ToDoAPI.getToDO().then((response) {
      setState(() {
        var responseData = json.decode(response.body);
        print(responseData);
        Iterable lista = responseData;
        taskList =
            lista.map((model) => Task.fromJson(model)).toList();
      });
    });
  }

  createTask(nome) async{
    ToDoAPI.postToDO(nome).then((response) {
      getTaskFromAPI();
    });
  }
  @override
  void initState() {
    getTaskFromAPI();
    super.initState();
  }
  List<String> _tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Form(
                key: _formKey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: taskController,
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                            hintText: 'Digite uma nova tarefa...',
                            hintStyle: TextStyle(
                              fontSize: 20,
                            )
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Campo é obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        child: Text('Add', style: TextStyle(fontSize: 20),),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                             createTask(taskController.text);
//                            setState(() {
//                              _tasks.add(taskController.text);
//                            });
                            taskController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(color:Colors.white ),
                        ),
//                        color: Colors.green,
//                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(taskList[index].nome),
                      trailing: Icon(Icons.delete),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}