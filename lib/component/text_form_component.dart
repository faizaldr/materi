import 'package:flutter/material.dart';

class TextFormComponent extends StatefulWidget {
  var prefixIcon1;
  var prefixIcon2;
  var hintText;
  var labelText;
  var isObsecure;
  var controller;
  var keyboardType;
  var validator;

  TextFormComponent(
    this.prefixIcon1,
    this.hintText,
    this.labelText,
    this.isObsecure,
    this.controller,
    this.keyboardType, 
    {
    Key? key,
    this.validator,
    this.prefixIcon2,
  }
  ) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TextFormComponentState();
  }
}

class _TextFormComponentState extends State<TextFormComponent> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: (widget.prefixIcon2 == null
            ? Icon(widget.prefixIcon1)
            : IconButton(
                onPressed: () {
                  widget.isObsecure = !widget.isObsecure;
                },
                icon: widget.isObsecure
                    ? widget.prefixIcon1
                    : widget.prefixIcon2,
              )),
        hintText: widget.hintText,
        labelText: widget.labelText,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        fillColor: Colors.white,
        filled: true,
      ),
      controller: widget.controller,
      obscureText: widget.isObsecure,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
    );
  }
}
