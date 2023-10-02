import 'package:flutter/material.dart';

enum Directions { up, down, right, left }

enum JoystickModes { all, horizontal, vertical }

class Joystick extends StatefulWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double opacity;
  final double size;
  final bool isDraggable;
  final JoystickModes joystickMode;

  //callbacks
  final VoidCallback onUpPressed;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;
  final VoidCallback onDownPressed;
  final Function(Directions) onPressed;

  const Joystick({
    super.key,
    required this.backgroundColor,
    required this.opacity,
    required this.size,
    required this.onUpPressed,
    required this.onLeftPressed,
    required this.onRightPressed,
    required this.onDownPressed,
    required this.onPressed,
    required this.isDraggable,
    required this.joystickMode,
    required this.iconColor,
  });

  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  double _x = 0;
  double _y = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: _y,
          right: _x,
          child: GestureDetector(
            onLongPress: (widget.isDraggable == false)
                ? null
                : () {
                    setState(() {
                      _x = 0;
                      _y = 0;
                    });
                  },
            child: Container(
              height: widget.size,
              width: widget.size,
              decoration: BoxDecoration(
                color: widget.backgroundColor.withOpacity(widget.opacity),
                shape: BoxShape.circle,
              ),
              child: Column(
                children: [
                  //up
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                              child: (widget.joystickMode ==
                                      JoystickModes.horizontal)
                                  ? const SizedBox()
                                  : IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: Icon(Icons.keyboard_arrow_up,
                                          color: (widget.iconColor == null)
                                              ? Colors.black
                                              : widget.iconColor),
                                      onPressed: () {
                                        widget.onUpPressed();
                                        widget.onPressed(Directions.up);
                                      },
                                    )),
                          const Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      )),
                  //middle
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              child: (widget.joystickMode ==
                                      JoystickModes.vertical)
                                  ? const SizedBox()
                                  : IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: Icon(Icons.keyboard_arrow_left,
                                          color: (widget.iconColor == null)
                                              ? Colors.black
                                              : widget.iconColor),
                                      onPressed: () {
                                        widget.onLeftPressed();
                                        widget.onPressed(Directions.left);
                                      },
                                    )),
                          Expanded(
                            child: GestureDetector(
                              child: Icon(Icons.drag_handle,
                                  color: (widget.iconColor == null)
                                      ? Colors.black
                                      : widget.iconColor),
                              onPanUpdate: (values) {
                                if (widget.isDraggable == true) {
                                  setState(() {
                                    _x -= values.delta.dx;
                                    _y -= values.delta.dy;
                                  });
                                }
                              },
                            ),
                          ),
                          Expanded(
                              child: (widget.joystickMode ==
                                      JoystickModes.vertical)
                                  ? const SizedBox()
                                  : IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: Icon(Icons.keyboard_arrow_right,
                                          color: (widget.iconColor == null)
                                              ? Colors.black
                                              : widget.iconColor),
                                      onPressed: () {
                                        widget.onRightPressed();
                                        widget.onPressed(Directions.right);
                                      },
                                    )),
                        ],
                      )),
                  //down
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Expanded(
                          child:
                              (widget.joystickMode == JoystickModes.horizontal)
                                  ? const SizedBox()
                                  : IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: Icon(Icons.keyboard_arrow_down,
                                          color: (widget.iconColor == null)
                                              ? Colors.black
                                              : widget.iconColor),
                                      onPressed: () {
                                        widget.onDownPressed();
                                        widget.onPressed(Directions.down);
                                      },
                                    ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
