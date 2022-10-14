import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = const Offset(0, 0);
  }

  void _onPanStart(BuildContext context, DragStartDetails details) {
    print(details.globalPosition.dy);
  }

  void _onPanUpdate(
      BuildContext context, DragUpdateDetails details, Offset offset) {
    setState(() {
      position = details.globalPosition;
    });
  }

  void _onPanEnd(BuildContext context, DragEndDetails details) {
    print(position);
    if (position.dy < 180 &&
        position.dy > 100 &&
        position.dx > 100 &&
        position.dx < 180) {
      setState(() {
        position = const Offset(120, 120);
      });
    } else {
      setState(() {
        position = const Offset(0, 0);
      });
    }
    print(details.velocity);
  }

  void _onPanCancel(BuildContext context) {
    print("Pan canceled !!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: SafeArea(
        child: LimitedBox(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                top: 120,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 120,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.green,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 120,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
              Positioned(
                top: position.dy,
                left: position.dx,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onPanStart: (details) => _onPanStart(context, details),
                      onPanUpdate: (details) =>
                          _onPanUpdate(context, details, position),
                      onPanEnd: (details) => _onPanEnd(context, details),
                      onPanCancel: () => _onPanCancel(context),
                      child: const SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                            child: Icon(
                          Icons.star,
                          size: 50,
                          color: Colors.yellow,
                        )),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        ;
  }
}
