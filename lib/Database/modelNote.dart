import 'package:notes/Database/dbConfig.dart';

class ModelNote {

  final DBConfig _dbConfig = DBConfig();

  // Crear una nota
  Future<int> create(String title, String note) async {
    final db = await _dbConfig.database;
    return await db.insert('Notes', {
      'title': title,
      'note': note,
    });
  }

  // Filters by Id, Title, or CreatedAt
  Future<Map<String, dynamic>?> findByID(
      {int? noteId, String? title, String? createdAt}) async {
    final db = await _dbConfig.database;

    String? whereClause;
    List<dynamic> whereArgs = [];

    if (noteId != null) {
      whereClause = 'note_id = ?';
      whereArgs.add(noteId);
    } else if (title != null) {
      whereClause = 'title = ?';
      whereArgs.add(title);
    } else if (createdAt != null) {
      whereClause = 'created_at = ?';
      whereArgs.add(createdAt);
    }

    // Ejecutar la consulta
    final result = await db.query(
      'Notes',
      where: whereClause,
      whereArgs: whereArgs,
    );

    return result.isNotEmpty ? result.first : null;
  }

  // Obtener todas las notas
  Future<List<Map<String, dynamic>>> findAll() async {
    final db = await _dbConfig.database;
    return await db.query('Notes');
  }

  // Actualizar una nota
  Future<int> update(String title, String note, int noteId) async {
    final db = await _dbConfig.database;
    return await db.update(
        'Notes',
        {
          'title': title,
          'note': note,
        },
        where: 'note_id = ?',
        whereArgs: [noteId]);
  }

  // Eliminar una nota
  Future<int> delete(int noteId) async {
    final db = await _dbConfig.database;
    return await db.delete('Notes', where: 'note_id = ?', whereArgs: [noteId]);
  }
}