// lib/screens/notes_screen.dart

import 'package:flutter/material.dart';
import 'package:todolist_application/constants/colors.dart';
import 'package:todolist_application/models/notebook.dart';  // Atualize para refletir o caminho correto

class NotesScreen extends StatefulWidget {
  final Notebook notebook;

  NotesScreen({required this.notebook});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addNote() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        widget.notebook.notes.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _deleteNote(int index) {
    setState(() {
      widget.notebook.notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: platinum,
      appBar: AppBar(
        title: Text(widget.notebook.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Adicionar afazeres',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNote,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.notebook.notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.notebook.notes[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteNote(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
