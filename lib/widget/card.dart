import 'package:flutter/material.dart';
import 'package:notes/Database/modelNote.dart';
import 'package:notes/widget/editNote.dart';

class CardScrollView extends StatefulWidget {
  @override
  _CardScrollViewState createState() => _CardScrollViewState();
}

class _CardScrollViewState extends State<CardScrollView> {
  List<Map<String, dynamic>> _notes = [];
  final ModelNote _modelNote = ModelNote();
  TextEditingController _searchController = TextEditingController(); // Controlador del TextField

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _searchController.addListener(_onSearchChanged); // Escuchar cambios en el campo de búsqueda
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Cargar todas las notas inicialmente
  Future<void> _loadNotes() async {
    final notes = await _modelNote.findAll();
    setState(() {
      _notes = notes;
    });
  }

  // Función de búsqueda que se llama cada vez que cambia el texto en el TextField
  void _onSearchChanged() async {
    if (_searchController.text.isEmpty) {
      _loadNotes(); // Si no hay texto, carga todas las notas
    } else {
      final filteredNotes = await _modelNote.filter(_searchController.text);
      setState(() {
        _notes = filteredNotes; // Actualizar las notas con las filtradas
      });
    }
  }

  Future<void> _deleteNote(int noteId) async {
    await _modelNote.delete(noteId); // Llamada para eliminar la nota
    _loadNotes(); // Recargar las notas después de eliminar
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController, // Asignar el controlador al TextField
              decoration: InputDecoration(
                hintText: 'Buscar notas...',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        Expanded(
          child: _notes.isEmpty
              ? Center(child: Text('CREA UNA NUEVA NOTA'))
              : ListWheelScrollView(
                  itemExtent: 100,
                  diameterRatio: 2.5,
                  physics: FixedExtentScrollPhysics(),
                  children: List.generate(
                    _notes.length,
                    (index) => _buildDismissibleCard(_notes[index]),
                  ),
                ),
        ),
      ],
    );
  }
  
  Widget _buildDismissibleCard(Map<String, dynamic> note) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _deleteNote(note['note_id']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: const Color.fromARGB(128, 238, 127, 127),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cancel, color: Colors.white),
                SizedBox(width: 12), // Espacio entre el ícono y el texto
                Expanded(
                  child: Text(
                    'Nota Eliminada',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Editnote(noteId: note['note_id']),
            ),
          );
          if (result == true) {
            _loadNotes();
          }
        },
        child: _buildCard(note),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> note) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: Color.fromARGB(128, 127, 134, 238),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    note['title'] ?? 'Sin título',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.attachment,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                note['created_at'] ?? 'Sin fecha',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
