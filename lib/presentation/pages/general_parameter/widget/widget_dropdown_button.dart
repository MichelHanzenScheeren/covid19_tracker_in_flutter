import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownButon extends StatelessWidget {
  final String currentValue;
  final List<String> summarys;
  final Function(String) onChange;

  DropdownButon({
    @required this.currentValue,
    @required this.summarys,
    this.onChange,
  }) : assert(summarys != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: currentValue,
              iconEnabledColor: Colors.white,
              style: GoogleFonts.raleway(fontSize: 25, color: Colors.grey[600]),
              underline: Container(
                height: 2,
                color: Colors.red,
              ),
              onChanged: onChange,
              items: summarys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 20),
                    child: Text(_getTranslateValue(value)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _getTranslateValue(String value) {
    if (value == 'North America') return 'America do Norte';
    if (value == 'South America') return 'America do Sul';
    if (value == 'Europe') return 'Europa';
    return value;
  }
}