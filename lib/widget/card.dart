import 'package:flutter/material.dart';
import 'package:notes/Database/modelNote.dart';

class CardScrollView extends StatefulWidget {
  @override
  _CardScrollViewState createState() => _CardScrollViewState();
}

class _CardScrollViewState extends State<CardScrollView> {
  List<Map<String, dynamic>> _notes = [];
  final ModelNote _modelNote = ModelNote();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  // Cargar las notas usando SeatService
  Future<void> _loadNotes() async {
    final notes = await _modelNote.findAll(); // Obtén las notas desde SeatService
    setState(() {
      _notes = notes;
    });
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
              decoration: InputDecoration(
                hintText: 'Buscar notas...',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('Search icon pressed');
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: _notes.isEmpty
              ? Center(child: Text('CREA UNA NUEVA NOTA')) // Muestra un mensaje si no hay notas
              : ListWheelScrollView(
                  itemExtent: 100,
                  diameterRatio: 2.5,
                  physics: FixedExtentScrollPhysics(),
                  children: List.generate(
                    _notes.length,
                    (index) => _buildCard(_notes[index]),
                  ),
                ),
        ),
      ],
    );
  }

  // Construir la tarjeta con los datos de la nota
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