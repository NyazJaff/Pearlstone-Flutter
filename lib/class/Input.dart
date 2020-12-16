import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../utilities/layout_helper.dart';

class Input extends StatefulWidget {
  final String   hint, label;
  final bool     typePass;
  final IconData leadingIcon;
  final TextEditingController controller;
  final void Function(String) onNameChangeCallback;

  const Input({Key key,
    this.label       = '',
    this.hint        = '',
    this.typePass    = false,
    this.leadingIcon = Icons.lock,
    this.controller,
    this.onNameChangeCallback}) : super(key: key);


  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            widget.label,
            style: kLabelStyle
        ),
        SizedBox(height: widget.label != '' ? 10.0 : 0),
        Container(
            alignment:  Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height:     widget.label != '' ? 60.0 : 50.0,
            child: TextField(
              onChanged: (String value)  {
                if (widget.onNameChangeCallback != null){
                  // if(value != widget.controller.text) {
                    widget.onNameChangeCallback(value);
                  // }
                }
              },
              controller:  widget.controller,
              obscureText: widget.typePass,
              style: TextStyle(
                  color:      textAndIconColour,
                  fontFamily: 'OpenSans'
              ),
              decoration:         InputDecoration(
                  border:         InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon:     Icon(
                    widget.leadingIcon,
                    color: textAndIconColour,
                  ),
                  hintText: widget.hint,
                  hintStyle: kHintTextStyle
              ),
            )
        )
      ],
    );
  }
}
