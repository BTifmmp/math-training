import 'package:flutter/material.dart';
import 'package:math_training/database/models/training_types.dart';

enum Operation { addition, substraction, multiplication, division, root, power }

enum GameSize { small, big }

class TrainingImageConfig {
  final String imgPath;
  final Color color;

  const TrainingImageConfig({
    required this.imgPath,
    required this.color,
  });

  factory TrainingImageConfig.fromSpeedType(SpeedTrainingType type) {
    return switch (type) {
      SpeedTrainingType.additionSubstractionEasy =>
        TrainingImageConfig.addSubstractSpeed,
      SpeedTrainingType.additionSubstractionMedium =>
        TrainingImageConfig.addSubstractSpeed,
      SpeedTrainingType.additionSubstractionHard =>
        TrainingImageConfig.addSubstractSpeed,
      SpeedTrainingType.multiplicationDivisionEasy =>
        TrainingImageConfig.multDivSpeed,
      SpeedTrainingType.multiplicationDivisionMedium =>
        TrainingImageConfig.multDivSpeed,
      SpeedTrainingType.multiplicationDivisionHard =>
        TrainingImageConfig.multDivSpeed,
      SpeedTrainingType.mixedEasy => TrainingImageConfig.mixedSpeed,
      SpeedTrainingType.mixedMedium => TrainingImageConfig.mixedSpeed,
      SpeedTrainingType.mixedHard => TrainingImageConfig.mixedSpeed,
      SpeedTrainingType.powerRootEasy => TrainingImageConfig.rootPowerSpeed,
      SpeedTrainingType.powerRootMedium => TrainingImageConfig.rootPowerSpeed,
      SpeedTrainingType.powerRootHard => TrainingImageConfig.rootPowerSpeed,
    };
  }

  factory TrainingImageConfig.fromMentalType(MentalTrainingType type) {
    return switch (type) {
      MentalTrainingType.additionSubstractionEasy =>
        TrainingImageConfig.addSubstractMental,
      MentalTrainingType.additionSubstractionMedium =>
        TrainingImageConfig.addSubstractMental,
      MentalTrainingType.additionSubstractionHard =>
        TrainingImageConfig.addSubstractMental,
      MentalTrainingType.multiplicationDivisionEasy =>
        TrainingImageConfig.multDivMental,
      MentalTrainingType.multiplicationDivisionMedium =>
        TrainingImageConfig.multDivMental,
      MentalTrainingType.multiplicationDivisionHard =>
        TrainingImageConfig.multDivMental,
      MentalTrainingType.mixedEasy => TrainingImageConfig.mixedMental,
      MentalTrainingType.mixedMedium => TrainingImageConfig.mixedMental,
      MentalTrainingType.mixedHard => TrainingImageConfig.mixedMental,
    };
  }

  factory TrainingImageConfig.fromGameType(GameType type) {
    return switch (type) {
      GameType.crossWordSmall => TrainingImageConfig.crossword,
      GameType.crossWardBig => TrainingImageConfig.crossword,
      GameType.magicSquareSmall => TrainingImageConfig.magicSqaure,
      GameType.magicSquareBig => TrainingImageConfig.magicSqaure,
    };
  }

  // ADDITION AND SUBSTRACTION
  static const addSubstractSpeed = TrainingImageConfig(
    imgPath: 'assets/images/plusminus.png',
    color: Color.fromARGB(255, 170, 230, 175),
  );

  static const addSubstractMental = TrainingImageConfig(
    imgPath: 'assets/images/plusminus.png',
    color: Color.fromARGB(255, 255, 191, 154),
  );

  // MULTIPLICATION AND DIVISION
  static const multDivSpeed = TrainingImageConfig(
    imgPath: 'assets/images/multdiv.png',
    color: Color.fromARGB(255, 221, 179, 248),
  );

  static const multDivMental = TrainingImageConfig(
    imgPath: 'assets/images/multdiv.png',
    color: Color.fromARGB(255, 162, 255, 240),
  );

  // POWERS AND ROOTS
  static const rootPowerSpeed = TrainingImageConfig(
    imgPath: 'assets/images/multdiv.png',
    color: Color.fromARGB(255, 179, 201, 248),
  );

  // MIXED
  static const mixedSpeed = TrainingImageConfig(
    imgPath: 'assets/images/mixed.png',
    color: Color.fromARGB(255, 255, 230, 154),
  );
  static const mixedMental = TrainingImageConfig(
    imgPath: 'assets/images/mixed.png',
    color: Color.fromARGB(255, 169, 154, 255),
  );

  // Games
  static const crossword = TrainingImageConfig(
    imgPath: 'assets/images/mixed.png',
    color: Color.fromARGB(255, 245, 255, 154),
  );

  static const magicSqaure = TrainingImageConfig(
    imgPath: 'assets/images/mixed.png',
    color: Color.fromARGB(255, 255, 154, 154),
  );
}

class TrainingConfig {
  final String title;
  final String diffcultyText;

  final List<Operation> availableOperations;

  final int addSubstractMax;
  final bool allowAddSubstractFractions;

  final int multDivMax;

  final int rootPowerMax;
  final bool allowRootPowerThirds;

  final Duration mentalTrainingDelay;

  const TrainingConfig(
      {this.title = 'Unnamed',
      this.diffcultyText = 'Not specified',
      this.allowRootPowerThirds = false,
      this.allowAddSubstractFractions = false,
      this.rootPowerMax = 0,
      this.availableOperations = const [],
      this.addSubstractMax = 0,
      this.multDivMax = 0,
      this.mentalTrainingDelay = const Duration(milliseconds: 3000)});

  // ADDITION AND SUBSTRACTION
  static const addSubstractEasy = TrainingConfig(
    title: 'Addition & Substraction',
    diffcultyText: 'Easy',
    availableOperations: [Operation.addition, Operation.substraction],
    addSubstractMax: 50,
  );

  static const addSubstractMedium = TrainingConfig(
    title: 'Addition & Substraction',
    diffcultyText: 'Medium',
    availableOperations: [Operation.addition, Operation.substraction],
    addSubstractMax: 100,
    allowAddSubstractFractions: true,
  );

  static const addSubstractHard = TrainingConfig(
    title: 'Addition & Substraction',
    diffcultyText: 'Hard',
    availableOperations: [Operation.addition, Operation.substraction],
    allowAddSubstractFractions: true,
    addSubstractMax: 500,
  );

  // MULTIPLICATION AND DIVISION
  static const multDivEasy = TrainingConfig(
    title: 'Multiplication & Division',
    diffcultyText: 'Easy',
    availableOperations: [Operation.multiplication, Operation.division],
    multDivMax: 10,
  );

  static const multDivMedium = TrainingConfig(
    title: 'Multiplication & Division',
    diffcultyText: 'Medium',
    availableOperations: [Operation.multiplication, Operation.division],
    multDivMax: 20,
  );

  static const multDivHard = TrainingConfig(
    title: 'Multiplication & Division',
    diffcultyText: 'Hard',
    availableOperations: [Operation.multiplication, Operation.division],
    multDivMax: 30,
  );

  // POWERS AND ROOTS
  static const rootPowerEasy = TrainingConfig(
    title: 'Powers & Roots',
    diffcultyText: 'Easy',
    availableOperations: [Operation.root, Operation.power],
    rootPowerMax: 101,
  );

  static const rootPowerMedium = TrainingConfig(
    title: 'Powers & Roots',
    diffcultyText: 'Medium',
    availableOperations: [Operation.root, Operation.power],
    rootPowerMax: 401,
    allowRootPowerThirds: true,
  );

  static const rootPowerHard = TrainingConfig(
    title: 'Powers & Roots',
    diffcultyText: 'Hard',
    availableOperations: [Operation.root, Operation.power],
    rootPowerMax: 901,
    allowRootPowerThirds: true,
  );

  // MIXED
  static const mixedEasy = TrainingConfig(
    title: 'Mixed',
    diffcultyText: 'Easy',
    availableOperations: [
      Operation.multiplication,
      Operation.division,
      Operation.addition,
      Operation.substraction,
      Operation.root,
      Operation.power,
    ],
    addSubstractMax: 50,
    multDivMax: 10,
    rootPowerMax: 101,
  );

  static const mixedMedium = TrainingConfig(
    title: 'Mixed',
    diffcultyText: 'Medium',
    availableOperations: [
      Operation.multiplication,
      Operation.division,
      Operation.addition,
      Operation.substraction,
      Operation.root,
      Operation.power,
    ],
    addSubstractMax: 100,
    allowAddSubstractFractions: true,
    multDivMax: 20,
    rootPowerMax: 401,
  );

  static const mixedHard = TrainingConfig(
    title: 'Mixed',
    diffcultyText: 'Hard',
    availableOperations: [
      Operation.multiplication,
      Operation.division,
      Operation.addition,
      Operation.substraction,
      Operation.root,
      Operation.power,
    ],
    addSubstractMax: 500,
    allowAddSubstractFractions: true,
    multDivMax: 30,
    rootPowerMax: 901,
  );

  // MIXED MENTAL
  static const mixedMentalEasy = TrainingConfig(
    title: 'Mixed',
    diffcultyText: 'Easy',
    availableOperations: [
      Operation.multiplication,
      Operation.division,
      Operation.addition,
      Operation.substraction,
    ],
    addSubstractMax: 50,
    multDivMax: 10,
  );

  static const mixedMentalMedium = TrainingConfig(
    title: 'Mixed',
    diffcultyText: 'Medium',
    availableOperations: [
      Operation.multiplication,
      Operation.division,
      Operation.addition,
      Operation.substraction,
    ],
    addSubstractMax: 100,
    allowAddSubstractFractions: true,
    multDivMax: 20,
  );

  static const mixedMentalHard = TrainingConfig(
    title: 'Mixed',
    diffcultyText: 'Hard',
    availableOperations: [
      Operation.multiplication,
      Operation.division,
      Operation.addition,
      Operation.substraction,
    ],
    addSubstractMax: 500,
    allowAddSubstractFractions: true,
    multDivMax: 30,
  );
}
