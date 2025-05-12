import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(TasbehApp());

class TasbehApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasbeh App',
      debugShowCheckedModeBanner: false,
      home: TasbehHome(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
    );
  }
}

class TasbehHome extends StatefulWidget {
  @override
  _TasbehHomeState createState() => _TasbehHomeState();
}

class _TasbehHomeState extends State<TasbehHome> {
  int _count = 33;
  int _maxCount = 33;

  String _selectedZikr = 'Subhanallah';
  final Map<String, int> zikrLimits = {
    'Subhanallah': 33,
    'Alhamdulillah': 33,
    'Allohu Akbar': 34,
    'La ilaha illallah': 100,
  };

  void _increment() {
    {
      setState(() {
        _count--;
      });
      HapticFeedback.lightImpact();
    }
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  void _changeZikr(String? newZikr) {
    if (newZikr != null) {
      setState(() {
        _selectedZikr = newZikr;
        _maxCount = zikrLimits[newZikr]!;
        _count = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = _count / _maxCount;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.teal.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Tasbeh',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '$_count / $_maxCount',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 12,
                  backgroundColor: Colors.white30,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _increment,
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.teal.shade900, width: 4),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.fingerprint,
                      size: 50,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Zikr aytish uchun bos',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: DropdownButtonFormField<String>(
                  value: _selectedZikr,
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Zikrni tanlang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items:
                      zikrLimits.keys.map((zikr) {
                        return DropdownMenuItem(value: zikr, child: Text(zikr));
                      }).toList(),
                  onChanged: _changeZikr,
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text('Qayta boshlash', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
