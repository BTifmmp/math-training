import 'package:flutter/material.dart';

class TrainingSelectModeBox extends StatefulWidget {
  final int difficulty;
  final String title;
  final String description;
  final GestureTapCallback onTap;
  final String image;

  const TrainingSelectModeBox(
      {super.key,
      required this.title,
      required this.description,
      required this.onTap,
      required this.difficulty,
      required this.image});

  @override
  State<TrainingSelectModeBox> createState() => _TrainingSelectModeBoxState();
}

class _TrainingSelectModeBoxState extends State<TrainingSelectModeBox> {
  double _scale = 1;
  int _duration = 50;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: _duration),
      scale: _scale,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => {
          setState(() {
            _scale = 0.97;
            _duration = 0;
          })
        },
        onTapUp: (_) => {
          setState(() {
            _scale = 1;
            _duration = 50;
          })
        },
        onTapCancel: () => {
          setState(() {
            _scale = 1;
            _duration = 50;
          })
        },
        child: Card.filled(
            color: Theme.of(context).colorScheme.surfaceContainer,
            shadowColor: Colors.black,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 150),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Image.asset(
                      widget.image,
                      width: 55,
                      height: 55,
                      color:
                          difficultyColors[widget.difficulty] ?? Colors.white,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

const Map<int, Color> difficultyColors = {
  0: Color.fromARGB(255, 107, 209, 110),
  1: Color.fromARGB(255, 228, 173, 101),
  2: Color.fromARGB(255, 209, 107, 107),
};
