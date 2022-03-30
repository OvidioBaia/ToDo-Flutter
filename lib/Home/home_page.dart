// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:listtodo/model/list.dart';
import 'package:listtodo/video/main.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Task> taskList = <Task>[];
  String titulo = '';
  String description = '';
  var formatoDataDaTarefa =  MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });

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

  createTask(title, description, date) async {
    ToDoAPI.postToDO(title, description, date).then((response) {
      getTaskFromAPI();
    });
  }

  delete(id) {
    ToDoAPI.deleteToDO(id).then((response) {
      getTaskFromAPI();
    });
  }

  clearField(){
    taskController.clear();
    descriptionController.clear();
    dateController.clear();
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
          actions: [IconButton(icon: Icon(Icons.video_file), color: Colors.white,onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyApp()));
            }),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(taskList[index].titulo),
                            subtitle: Text(taskList[index].description),
                            trailing: Text(taskList[index].date),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  await delete(taskList[index].id);
                                },
                              ),
                            //  const SizedBox(width: 8),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: const Text("Add Todo"),
                actions: <Widget>[
                  TextButton(onPressed: () async {
                    //todos.add(title);
                    if (_formKey.currentState!.validate()) {
                      await createTask(taskController.text, descriptionController.text, dateController.text);
                      clearField();
                      Navigator.of(context).pop();
                    }
                  },
                      child: const Text("Add")
                  ),
                ],
                content: Container(
                  width: 400,
                  height: 400,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 60,
                                child: TextFormField(
                                    controller: taskController,
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black,),
                                    decoration: InputDecoration(
                                        hintText: 'Tarefa...',
                                        hintStyle: TextStyle(fontSize: 20,)
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
                                height: 60,
                                child: TextFormField(
                                    controller: descriptionController,
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintText: 'Descrição...',
                                        hintStyle: TextStyle(fontSize: 20,)
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
                                child: TextFormField(
                                  controller: dateController,
                                  inputFormatters: [formatoDataDaTarefa],
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black),
                                  decoration: InputDecoration(
                                      hintText: 'Data...',
                                      hintStyle: TextStyle(fontSize: 20,)
                                  ),
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Campo é obrigatório';
                                    }
                                    return null;
                                  },
                                ),
                              )

//                    TextField(
//                      onChanged: (String value) {
//                        titulo = value;
//                      },),
//                            TextField(onChanged: (String value) {
//                              description = value;
//                            },),
                            ],
                          ),
                        ),
                      ),
                    ],),
                ),
              );
            });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
    );
  }
}