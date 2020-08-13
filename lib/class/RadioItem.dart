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
            Text(
              _item.key.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color:
                _item.isSelected ? textAndIconColour : Colors.grey[500],
              ),
            ),
            SizedBox(
              height: 7,
            ),
//            Icon(
//              _item.icon,
//              color: _item.isSelected ? textAndIconColour : Colors.grey[500],
//              size: 35,
//            ),
            Text(
              _item.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontFamily: '',
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