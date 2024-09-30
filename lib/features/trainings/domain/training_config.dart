enum Operation { addition, substraction, multiplication, division, root, power }

class TrainingConfig {
  final List<Operation> availableOperations;

  final int addSubstractMax;
  final bool allowAddSubstractFractions;

  final int multDivMax;

  final int rootPowerMax;
  final bool allowRootPowerThirds;

  final Duration mentalTrainingDelay;

  const TrainingConfig(
      {this.allowRootPowerThirds = false,
      this.allowAddSubstractFractions = false,
      this.rootPowerMax = 0,
      this.availableOperations = const [],
      this.addSubstractMax = 0,
      this.multDivMax = 0,
      this.mentalTrainingDelay = Duration.zero});

  // ADDITION AND SUBSTRACTION
  static const addSubstractEasy = TrainingConfig(
    availableOperations: [Operation.addition, Operation.substraction],
    addSubstractMax: 50,
  );

  static const addSubstractMedium = TrainingConfig(
    availableOperations: [Operation.addition, Operation.substraction],
    addSubstractMax: 100,
    allowAddSubstractFractions: true,
  );

  static const addSubstractHard = TrainingConfig(
    availableOperations: [Operation.addition, Operation.substraction],
    allowAddSubstractFractions: true,
    addSubstractMax: 500,
  );

  // MULTIPLICATION AND DIVISION
  static const multDivEasy = TrainingConfig(
    availableOperations: [Operation.multiplication, Operation.division],
    multDivMax: 10,
  );

  static const multDivMedium = TrainingConfig(
    availableOperations: [Operation.multiplication, Operation.division],
    multDivMax: 20,
  );

  static const multDivHard = TrainingConfig(
    availableOperations: [Operation.multiplication, Operation.division],
    multDivMax: 30,
  );

  // POWERS AND ROOTS
  static const rootPowerEasy = TrainingConfig(
    availableOperations: [Operation.root, Operation.power],
    rootPowerMax: 101,
  );

  static const rootPowerMedium = TrainingConfig(
    availableOperations: [Operation.root, Operation.power],
    rootPowerMax: 401,
    allowRootPowerThirds: true,
  );

  static const rootPowerHard = TrainingConfig(
    availableOperations: [Operation.root, Operation.power],
    rootPowerMax: 901,
    allowRootPowerThirds: true,
  );

  // MIXED
  static const mixedEasy = TrainingConfig(
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
}
