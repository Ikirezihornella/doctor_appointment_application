import 'package:flutter/material.dart';
import 'dart:async';
import 'symptoms_page.dart';
import 'sign_up.dart';
import 'login_page.dart';
import 'appointment_booking.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Appointment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  bool _isLoggedIn = false;

  late AnimationController _controller;
  final List<String> _imageUrls = [
    'https://t3.ftcdn.net/jpg/10/77/98/48/360_F_1077984897_nnqvXyDHQ0nca0vbnzmczlUFRRDol8Hq.jpg',
    'https://t3.ftcdn.net/jpg/02/38/08/42/360_F_238084232_5XhGUddDZezzJxybvVXzfPp8cOKAuqRp.jpg',
    // 'https://static.vecteezy.com/system/resources/thumbnails/004/987/898/small/doctor-in-medical-lab-coat-with-a-stethoscope-doctor-in-hospital-background-with-copy-space-low-poly-wireframe-vector.jpg',
    'https://t3.ftcdn.net/jpg/05/52/06/54/360_F_552065481_f2v6KugntlxzdMRitcgOh2i5PpiTtFGl.jpg',
  ];
  int _currentImageIndex = 0;
  Timer? _imageTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _imageTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _imageUrls.length;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (String url in _imageUrls) {
      precacheImage(NetworkImage(url), context);
    }
  }

  void _onLoginSuccess() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Get your consultation & get recommendations here',
         style: TextStyle(fontSize: 16.3 , fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(seconds: 2),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: Image.network(
              _imageUrls[_currentImageIndex],
              key: ValueKey<String>(_imageUrls[_currentImageIndex]),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Animated gradient 
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.3 + (0.2 * _controller.value)),
                      Colors.green.withOpacity(0.3 + (0.2 * _controller.value)),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello There',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SymptomsPage()),
                        );
                      },
                      child: Text('Symptoms'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_isLoggedIn) {
                          Navigator.pop(context);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(onLoginSuccess: _onLoginSuccess),
                            ),
                          );
                        }
                      },
                      child: Text('Appointments'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageTimer?.cancel();
    super.dispose();
  }
}
