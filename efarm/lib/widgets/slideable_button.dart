import 'package:flutter/material.dart';

class SlideableButton extends StatefulWidget {
  const SlideableButton({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;

  @override
  _SlideableButtonState createState() => _SlideableButtonState();
}

class _SlideableButtonState extends State<SlideableButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;
  String _selectedValue = 'Farmers';

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = Tween<Alignment>(
        begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey[400],
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Align(
                  alignment: _animation.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Farmers',
                  style: TextStyle(
                    color: _selectedValue == 'Farmers'
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Consumers',
                  style: TextStyle(
                    color: _selectedValue == 'Consumers'
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggle() {
    if (_controller.isCompleted) {
      _controller.reverse();
      _selectedValue = 'Farmers';
    } else {
      _controller.forward();
      _selectedValue = 'Consumers';
    }

    if (widget.onChanged != null) {
      widget.onChanged!(_selectedValue);
    }
  }
}
