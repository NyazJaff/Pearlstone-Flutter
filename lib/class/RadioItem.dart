import 'package:flutter/material.dart';
import 'package:pearlstone/model/RadioModel.dart';
import 'package:pearlstone/utilities/constants.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              _item.icon,
              color: _item.isSelected ? textAndIconColour : Colors.grey[500],
              size: 35,
            ),
            Text(
              _item.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color:
                _item.isSelected ? textAndIconColour : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}