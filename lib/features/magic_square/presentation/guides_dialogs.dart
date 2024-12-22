import 'package:flutter/material.dart';

class MagicGuide3 extends StatelessWidget {
  const MagicGuide3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Guide 3x3'),
        scrolledUnderElevation: 0.0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tips below can be applied symmetrically',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset(
                    'assets/images/guide/sq0.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      '3×E = magic sum',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Image.asset(
                    'assets/images/guide/sq1.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      'G+E = F+I',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Image.asset(
                    'assets/images/guide/sq2.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      'G+H = C+F',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Image.asset(
                    'assets/images/guide/sq3.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      'C+G = D+F',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Image.asset(
                    'assets/images/guide/sq4.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      'B+H = D+F',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Image.asset(
                    'assets/images/guide/sq5.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      'Solve the equation\n3×E = B+H+E\n2E = B+H',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class MagicGuide4 extends StatelessWidget {
  const MagicGuide4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Guide 4x4'),
        scrolledUnderElevation: 0.0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tips below can be applied symmetrically',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset(
                    'assets/images/guide/sq8.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      'A+C+I+K = magic sum',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Image.asset(
                    'assets/images/guide/sq6.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      'A+D = N+O',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Image.asset(
                    'assets/images/guide/sq7.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      'D+M = F+K',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
