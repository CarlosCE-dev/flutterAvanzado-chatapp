import 'package:flutter/material.dart';

class Label extends StatelessWidget {

  final String route;
  final String primaryText;
  final String secodaryText;

  Label({
    @required this.route, 
    @required this.primaryText, 
    @required this.secodaryText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(primaryText, style: TextStyle( color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300 ) ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context, route);
            },
            child: Text(secodaryText, style: TextStyle( color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold ) )
          )
        ],
      ),
    );
  }
}
