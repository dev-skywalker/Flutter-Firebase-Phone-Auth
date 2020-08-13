import 'package:flutter/material.dart';

class EditTextUtils {
  TextFormField getCustomEditTextArea(
      {String labelValue = "",
        String hintValue = "",
        Function validator,
        IconData icon,
        bool validation,
        TextEditingController controller,
        TextInputType keyboardType = TextInputType.text,
        String validationErrorMsg,}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon,color: Colors.deepPurpleAccent,),
        prefixStyle: TextStyle(color: Colors.deepPurpleAccent),
        fillColor: Colors.white.withOpacity(0.6),
        filled: true,
        isDense: true,
        labelStyle: TextStyle(color: Colors.deepPurpleAccent),
        focusColor: Colors.deepPurpleAccent,
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
          borderSide: new BorderSide(
            color: Colors.deepPurpleAccent,
            width: 1.0,
          ),
        ),
        disabledBorder: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
          borderSide: new BorderSide(
            color: Colors.deepPurpleAccent,
            width: 1.0,
          ),
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
          borderSide: new BorderSide(
            color: Colors.deepPurpleAccent,
            width: 1.0,
          ),
        ),
        hintText: hintValue,
        labelText: labelValue,),
      validator: validator,
    );
  }
}
