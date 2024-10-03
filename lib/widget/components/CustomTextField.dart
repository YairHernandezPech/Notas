import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String? initialValue;
  final int? maxLines;
  final int? minLines;
  final TextStyle? varianText;
  // final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.initialValue,
    this.maxLines = 1,
    this.minLines = 1,
    this.varianText,
    // this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,  // Permite ocultar el texto si se desea
      cursorColor: Colors.black87,  // Color del cursor
      maxLines: maxLines,
      minLines: minLines,
      style: varianText,
      decoration: InputDecoration(
        hintText: 'Ingrese su texto aquí',
        filled: true,
        fillColor: Color.fromARGB(130, 255, 255, 255),
        labelText: labelText,  // Texto de la etiqueta
        labelStyle: TextStyle(color: Colors.black87),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),  // Color del borde cuando no está enfocado
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),  // Color del borde cuando está enfocado
        ),
      ),
      // onChanged: onChanged,  // Acción cuando el texto cambia
      controller: TextEditingController(text: initialValue),  // Valor inicial del campo
    );
  }
}
