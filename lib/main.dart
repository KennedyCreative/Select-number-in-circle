import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyTest(),
  ));
}

class MyTest extends StatefulWidget {
  const MyTest({Key? key}) : super(key: key);

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  double _angle = 0.0;
  bool _isRotating = false;
  int _selectedNumber = -1;
  final int _totalNumbers = 10;
  final double _circleRadius = 20.0;
  final double _containerRadius = 80.0;
  final double _centerX = 100.0;
  final double _centerY = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _containerRotation(),
            SizedBox(height: 20),
            Text(
              'Número selecionado: $_selectedNumber',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _containerRotation() {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          _isRotating = true;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _angle += details.delta.dx / 100;
          _updateSelectedNumber();
        });
      },
      onPanEnd: (details) {
        setState(() {
          _isRotating = false;
        });
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _isRotating ? Colors.green : Colors.transparent,
            width: 4,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            for (var i = 0; i < _totalNumbers; i++)
              Positioned(
                left: _centerX + _containerRadius * math.cos(i * 2 * math.pi / _totalNumbers - math.pi / 2) - 10,
                top: _centerY + _containerRadius * math.sin(i * 2 * math.pi / _totalNumbers - math.pi / 2) - 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedNumber = i;
                    });
                  },
                  child: Text(
                    '$i',
                    style: TextStyle(
                      fontSize: 20,
                      color: _selectedNumber == i ? Colors.red : Colors.black,
                    ),
                  ),
                ),
              ),
            Positioned(
              left: _centerX - _circleRadius,
              top: _centerY - _circleRadius,
              child: Container(
                width: _circleRadius * 2,
                height: _circleRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSelectedNumber() {
    final double selectedAngle = _angle % (2 * math.pi);
    final double deltaAngle = 2 * math.pi / _totalNumbers;
    int selectedNumber = ((selectedAngle + math.pi / 2) / deltaAngle).floor();
    if (selectedNumber != _selectedNumber) {
      setState(() {
        _selectedNumber = (selectedNumber % _totalNumbers);
      });
    }
  }
}
