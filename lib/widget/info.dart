import 'package:flutter/material.dart';
import 'package:notes/Database/modelNote.dart';
import 'package:notes/widget/components/BubbleWidget.dart';
import 'package:notes/widget/components/CustomTextField.dart';
import 'package:notes/widget/editNote.dart';

class Infonote extends StatefulWidget {
  final int noteId;

  Infonote({required this.noteId});

  @override
  _InfonoteState createState() => _InfonoteState();
}

class _InfonoteState extends State<Infonote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final ModelNote modelNote = ModelNote();

  @override
  void initState() {
    super.initState();
    _loadNoteData();
  }

  Future<void> _loadNoteData() async {
    // Cargar la nota utilizando el noteId
    List<Map<String, dynamic>> noteData =
        await modelNote.findByID(widget.noteId);

    if (noteData.isNotEmpty) {
      setState(() {
        // Asignar los valores a los controladores
        titleController.text = noteData[0]['title'];
        noteController.text = noteData[0]['note'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nota'),
        backgroundColor: Color.fromARGB(128, 127, 134, 238),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Editnote(noteId: widget.noteId),
                  ),
                );
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Stack(
        children: [
          BubbleWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ListView(
              children: [
                const SizedBox(height: 10),
                TextField(
                  obscureText: false,
                  enabled: false,
                  maxLines: 1,
                  controller: titleController,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: false,
                  enabled: false,
                  maxLines: null,
                  minLines: 20,
                  controller: noteController,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
