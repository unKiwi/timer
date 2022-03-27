import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer/data.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<DataRow> lsTimer;

  @override
  Widget build(BuildContext context) {
    lsTimer = [];
    Data.list.forEach((key, value) {
      var color;
      var icon;
      if (DateTime.now().millisecondsSinceEpoch >= value) {
        color = Colors.green;
        icon = Icons.check;
      }
      else {
        color = Colors.red;
        icon = Icons.close;
      }

      lsTimer.add(DataRow(
        cells: [
          DataCell(Text(key)),
          DataCell(Icon(
            icon,
            color: color,
          ),),
          DataCell(IconButton(
            onPressed: () {
              Data.list.removeWhere((key2, value2) => value2 == value);
              Data.save();
              setState(() {
                
              });
            },
            icon: Icon(Icons.delete),
          )),
        ]
      ));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Delete")),
              ],
              rows: lsTimer,
            ),
            IconButton(onPressed: () {
              setState(() {
                
              });
            }, icon: Icon(Icons.refresh))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final _formKey = GlobalKey<FormState>();
          TextEditingController _controllerName = TextEditingController();
          TextEditingController _controllerHours = TextEditingController();
          TextEditingController _controllerMinutes = TextEditingController();

          await showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Create Timer"),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _controllerName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Int required';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: TextFormField(
                          controller: _controllerHours,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Hours',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Int required';
                            }
                            return null;
                          },
                        ),
                      ),
                      TextFormField(
                        controller: _controllerMinutes,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Minutes',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Int required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // save new timer
                        Data.createTimer(_controllerName.text, int.parse(_controllerHours.text), int.parse(_controllerMinutes.text));

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            }
          );

          setState(() {
            
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}