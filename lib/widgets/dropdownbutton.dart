import 'package:flutter/material.dart';


class DropBtn extends StatefulWidget {
  const DropBtn({ Key? key }) : super(key: key);

  @override
  State<DropBtn> createState() => _DropBtnState();
}

class _DropBtnState extends State<DropBtn> {

  String dropdownValue = 'Black';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      elevation: 1,
      items: <String>['Black', 'LtBlue', 'Pink', 'Orange'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}