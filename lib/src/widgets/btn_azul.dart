import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final Function onPress;

  BotonAzul({
    @required this.text, 
    @required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPress,
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(this.text, style: TextStyle( color: Colors.white, fontSize: 17 )),
        ),
      ),
    );
  }
}