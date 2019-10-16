import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './util.dart';

class Bmi extends StatefulWidget {
  @override
  _BmiState createState() => _BmiState();
}

class _BmiState extends State<Bmi> {
  TextEditingController heightController;
  TextEditingController weightController;
  int unit;

  @override
  void initState() {
    heightController = TextEditingController();
    weightController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    heightController = null;
    weightController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('BMI'),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: height * 0.8),
                child: Column(
                  children: <Widget>[
                    Image.network('https://bit.ly/img_bmi'),
                    Util.paddingTop,
                    Row(
                      children: <Widget>[
                        Util.paddingLeft,
                        Container(width: width / 3, child: Text('Height')),
                        Expanded(
                          child: CupertinoTextField(
                            controller: heightController,
                            clearButtonMode: OverlayVisibilityMode.editing,
                          ),
                        ),
                        Util.paddingLeft,
                      ],
                    ),
                    Util.paddingTop,
                    Row(
                      children: <Widget>[
                        Util.paddingLeft,
                        Container(width: width / 3, child: Text('Weight')),
                        Expanded(
                          child: CupertinoTextField(
                            controller: weightController,
                            clearButtonMode: OverlayVisibilityMode.editing,
                          ),
                        ),
                        Util.paddingLeft,
                      ],
                    ),
                    Expanded(child: Container(child: Util.paddingTop)),
                    CupertinoButton.filled(
                      child: Text('Calculate BMI'),
                      onPressed: showResult,
                    ),
                    Util.paddingTop,
                  ],
                )),
          ),
        ));
  }

  void onSetting(int value) {
    setState(() {
      unit = value;
    });
  }

  void showResult() async {
    double _height;
    double _weight;

    int unit = await Util.getSettings();

    _height = double.tryParse(heightController.text);
    _weight = double.tryParse(weightController.text);

    double result = Util.calculateBMI(_height, _weight, unit);

    String message = 'Your BMI is ' + result.toStringAsFixed(2);
    CupertinoAlertDialog dialog = CupertinoAlertDialog(
      title: Text('Result'),
      content: Text(message),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}
