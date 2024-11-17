import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UnitConverter(),
    );
  }
}

class UnitConverter extends StatefulWidget {
  const UnitConverter({super.key});

  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  String _fromUnit = 'Meters';
  String _toUnit = 'Kilometers';
  late double _inputValue;
  String _result = '';

  final Map<String, double> lengthUnits = {
    'Kilometers': 0.001,
    'Hectometers': 0.01,
    'Decameters': 0.1,
    'Meters': 1.0,
    'Decimeters': 10.0,
    'Centimeters': 100.0,
    'Millimeters': 1000.0,
    'Miles': 0.000621371,
    'Feet': 3.28084,
  };

  final Map<String, double> weightUnits = {
    'Kilograms': 1.0,
    'Grams': 1000.0,
  };

  void _convert() {
    setState(() {
      if (lengthUnits.containsKey(_fromUnit) && lengthUnits.containsKey(_toUnit)) {
        double valueInMeters = _inputValue * lengthUnits[_fromUnit]!;
        double convertedValue = valueInMeters / lengthUnits[_toUnit]!;
        _result = convertedValue.toString();
      } else if (weightUnits.containsKey(_fromUnit) && weightUnits.containsKey(_toUnit)) {
        double valueInKilograms = _inputValue * weightUnits[_fromUnit]!;
        double convertedValue = valueInKilograms / weightUnits[_toUnit]!;
        _result = convertedValue.toString();
      } else {
        _result = 'Conversion not supported';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        backgroundColor: Colors.amber,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _fromUnit,
              onChanged: (newValue) {
                setState(() {
                  _fromUnit = newValue!;
                });
              },
              items: lengthUnits.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList() +
              weightUnits.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Enter Value'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _inputValue = double.parse(value);
              },
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _toUnit,
              onChanged: (newValue) {
                setState(() {
                  _toUnit = newValue!;
                });
              },
              items: lengthUnits.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList() +
              weightUnits.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Result',
                enabled: false,
                // Disable the text field to make it read-only
              ),
              controller: TextEditingController(text: _result),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}
