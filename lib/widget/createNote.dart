import 'package:flutter/material.dart';
import 'package:notes/widget/components/BubbleWidget.dart';
import 'package:notes/widget/components/CustomTextField.dart';

class Createnote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BubbleWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ListView(
            children: [
              CustomTextField(
                labelText: 'Titulo',
                obscureText: false, 
                initialValue: 'YO', 
                maxLines: null,
                varianText: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              CustomTextField(
                labelText: 'Cuerpo',
                obscureText: false, 
                initialValue: 'Hola es esl cuerpo', 
                maxLines: null,
                minLines: 5
              ),
              SizedBox(height: 16),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20, // Ajusta la posición vertical del botón
                child: SizedBox(
                  height: 60, // Altura del botón
                  child: ElevatedButton(
                    onPressed: () {
                      print('Botón Guardar presionado');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60), // Ancho completo
                      backgroundColor: Color.fromARGB(128, 127, 134, 238),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Bordes redondeados
                      ),
                    ),
                    child: Text(
                      'Guardar',
                      style: TextStyle(fontSize: 20, color: Colors.white), // Estilo del texto
                    ),
                  ),
                ),
              ),

            ],
          ),
          
        )
      ],
    );
  }
}



