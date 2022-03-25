import 'dart:math' as MATH;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CircleVortex());
}

class CircleVortex extends StatelessWidget {
  const CircleVortex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController modController = TextEditingController(text: "2");
  TextEditingController limitController = TextEditingController(text: "50");
  TextEditingController vortexController = TextEditingController(text: "10");

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Container(
              width: screenSize.width - 20,
              height: screenSize.width - 20,
              color: Colors.blue,
              child: CustomPaint(
                painter: VortexPainter(
                  mod: int.parse(modController.text),
                  limit: int.parse(limitController.text),
                  vortex: int.parse(vortexController.text),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Mod"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (int.parse(modController.text) > 1) {
                          modController.text =
                              (int.parse(modController.text) - 1).toString();
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_downward,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextField(
                    controller: modController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          modController.text = "1";
                        }
                      });
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  )),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        modController.text =
                            (int.parse(modController.text) + 1).toString();
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_upward,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Limit"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (int.parse(limitController.text) > 5) {
                          limitController.text =
                              (int.parse(limitController.text) - 1).toString();
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_downward,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextField(
                    controller: limitController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          limitController.text = "1";
                        }
                      });
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  )),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        limitController.text =
                            (int.parse(limitController.text) + 1).toString();
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_upward,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Vortex"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (int.parse(vortexController.text) > 1) {
                          vortexController.text =
                              (int.parse(vortexController.text) - 1).toString();
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_downward,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextField(
                    controller: vortexController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          vortexController.text = "1";
                        }
                      });
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  )),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        vortexController.text =
                            (int.parse(vortexController.text) + 1).toString();
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_upward,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VortexPainter extends CustomPainter {
  final int mod;
  final int limit;
  final int vortex;

  VortexPainter({
    required this.mod,
    required this.limit,
    required this.vortex,
  });

  List<VortexModel> _getVortexLineNumbers() {
    List<VortexModel> vortexLinesNumber = [];
    for (int i = 1; i <= limit; i++) {
      if (vortexLinesNumber.isEmpty) {
        vortexLinesNumber.add(VortexModel(first: i, last: 1));
      } else {
        int tmp = i * mod;
        if (tmp > limit) {
          break;
        }
        vortexLinesNumber.add(VortexModel(first: i, last: tmp));
      }
    }
    print(vortexLinesNumber);
    return vortexLinesNumber;
  }

  List<VortexLineOffset> _getPoints(Size size) {
    List<VortexLineOffset> points = [];
    List<VortexModel> vortexLinesNumber = _getVortexLineNumbers();

    for (var i in vortexLinesNumber) {
      double k = vortex * 180 / 360;
      double x1 = (size.width / 2) +
          (size.width / 2) *
              (MATH.cos(1.3527 + MATH.pi - (i.first * (MATH.pi / k))));
      double y1 = (size.width / 2) +
          (size.width / 2) *
              (MATH.sin(1.3527 + MATH.pi - (i.first * (MATH.pi / k))));

      double x2 = (size.width / 2) +
          (size.width / 2) *
              (MATH.cos(1.3527 + MATH.pi - (i.last * (MATH.pi / k))));
      double y2 = (size.width / 2) +
          (size.width / 2) *
              (MATH.sin(1.3527 + MATH.pi - (i.last * (MATH.pi / k))));
      points.add(
        VortexLineOffset(
          start: Offset(x1, y1),
          end: Offset(x2, y2),
        ),
      );
    }

    return points;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // path to draw vortex lines.
    Path _path = Path();
    List<VortexLineOffset> vortexLinesOffset = _getPoints(size);
    List<Offset> vortexPointsOnCircleBorderOffset = [];

    // circle center and radius.
    Offset circleCenter = size.center(Offset.zero);
    double circleRadius = size.width / 2;

    // drawing vortex circle.
    canvas.drawCircle(
        circleCenter,
        circleRadius,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);

    for (var element in vortexLinesOffset) {
      canvas.drawLine(element.start, element.end, Paint()..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class VortexModel {
  final int first;
  final int last;

  VortexModel({required this.first, required this.last});
}

class VortexLineOffset {
  final Offset start;
  final Offset end;

  VortexLineOffset({required this.start, required this.end});
}
