import 'package:flutter/material.dart';
import 'package:pearlstone/model/RadioModel.dart';
import 'RadioItem.dart';

class SelectableCard extends StatefulWidget {
  final List<RadioModel> options;
  final int step;
  SelectableCard({@required this.options, @required this.step});

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  List<RadioModel> sampleData = new List<RadioModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //sampleData = widget.options;
    //print(sampleData.toString());
  }

  @override
  Widget build(BuildContext context) {
    sampleData = widget.options;
    print(sampleData.toString());
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2.5),
      ),
      itemCount: sampleData.length,
      itemBuilder: (context, index) {
        return Card(
          shape: sampleData[index].isSelected
              ? RoundedRectangleBorder(
              side: BorderSide(color: Colors.indigoAccent, width: 2.0),
              borderRadius: BorderRadius.circular(4.0))
              : RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[200], width: 2.0),
              borderRadius: BorderRadius.circular(4.0)),
          color: Colors.white,
          elevation: 0,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
                print('step ${widget.step}');
                print('index ${index}');
//                answer[widget.step] = index;
//                print(answer[widget.step]);
              });
            },
            child: GridTile(child: RadioItem(sampleData[index])),
          ),
        );
      },
    );
  }
}