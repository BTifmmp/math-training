enum Operation { addition, substraction, multiplication, division, root, power }

enum GameSize { small, big }

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
