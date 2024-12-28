import 'package:flutter/material.dart';

class ModernSpinner extends StatefulWidget {
  final double size;
  final Color color;

  const ModernSpinner({Key? key, this.size = 50.0, this.color = Colors.blue})
      : super(key: key);

  @override
  ModernSpinnerState createState() => ModernSpinnerState();
}

class ModernSpinnerState extends State<ModernSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * 3.141592653589793,
              child: CustomPaint(
                painter: _CircularSpinnerPainter(color: widget.color),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CircularSpinnerPainter extends CustomPainter {
  final Color color;

  _CircularSpinnerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..addArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        0,
        3.141592653589793 * 1.5,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
