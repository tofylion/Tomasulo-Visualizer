import 'package:flutter/cupertino.dart';

import 'instruction.dart' as instruction;
import 'register.dart';

import 'operation_station.dart' as operation_station;
import 'package:tuple/tuple.dart';

abstract class ReservationStationElement extends ChangeNotifier {
  final String ID;
  bool _busy = false;
  bool operating = false;
  bool get busy => _busy;
  instruction.Instruction? _currentInstruction;
  instruction.Instruction? get currentInstruction => _currentInstruction;
  bool _ready = false;
  bool get ready => _ready;
  List<Function(double, String)> listeners = <Function(double, String)>[];
  RegisterFile registers;

  ReservationStationElement(this.ID, this.registers);
  void checkReady();

  instruction.InstructionType? getType() {
    return _currentInstruction?.type;
  }

  @override
  String toString() {
    return ('busy : $busy, ready : $ready, $currentInstruction');
  }

  void freeStation() {
    _busy = false;
    _ready = false;
    operating = false;
    notifyListeners();
  }

  void allocate(instruction.Instruction i) {
    _currentInstruction = i;
    _busy = true;
    _ready = false;
    getData();
    notifyListeners();
  }

  void addDataListener(Function(double, String) f) {
    listeners.add(f);
  }

  void notifyDataListeners(double data) {
    while (listeners.isNotEmpty) {
      listeners.first(data, ID);
      listeners.removeAt(0);
    }
  }

  void removeListner(Function(double) f) {
    listeners.remove(f);
  }

  void listenFirstOperand(double data, String id) {
    if (_currentInstruction != null) {
      _currentInstruction!.operand1Val = data;
      _currentInstruction!.operand1ID = null;
      checkReady();

      notifyListeners();
    }
  }

  void listenSecondOperand(double data, String id) {
    if (_currentInstruction != null) {
      _currentInstruction!.operand2Val = data;
      _currentInstruction!.operand2ID = null;
      notifyListeners();
      checkReady();
    }
  }

  void getData();
}

class AddressUnit extends ReservationStationElement {
  MemoryBuffer loadBuffer;
  MemoryBuffer storeBuffer;
  int? address;

  AddressUnit(super.ID, super.registers, this.loadBuffer, this.storeBuffer);

  @override
  void checkReady() {
    if (!_busy) {
      _ready = false;
    } else {
      _ready = _currentInstruction!.operand2ID == null;
    }
  }

  @override
  void getData() {
    Tuple2<double, String?> res = registers.getRegister(
        _currentInstruction!.operand2Reg!, listenSecondOperand);
    _currentInstruction!.operand2Val = res.item1;
    _currentInstruction!.operand2ID = res.item2;
  }

  @override
  bool allocate(instruction.Instruction i) {
    if (checkType(i.type)) {
      if (!busy) {
        _currentInstruction = i;
        _busy = true;
        getData();
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  @override
  void listenSecondOperand(double data, String id) {
    if (_currentInstruction != null) {
      _currentInstruction!.operand2Val = data;
      _currentInstruction!.operand2ID = null;
      address = (data + _currentInstruction!.addressOffset!).round();
      checkReady();
    }
  }

  void issue() {
    switch (_currentInstruction!.type) {
      case instruction.InstructionType.load:
        issueLoad();
        break;
      case instruction.InstructionType.store:
        issueStore();
        break;

      case instruction.InstructionType.add:
        // TODO: Handle this case.
        break;
      case instruction.InstructionType.sub:
        // TODO: Handle this case.
        break;
      case instruction.InstructionType.mult:
        // TODO: Handle this case.
        break;
      case instruction.InstructionType.div:
        // TODO: Handle this case.
        break;
      case instruction.InstructionType.load:
        // TODO: Handle this case.
        break;
      case instruction.InstructionType.store:
        // TODO: Handle this case.
        break;
    }
  }

  // are you asleep ??? ........
  // good night ... morning bel manzar da
  void issueStore() {
    if (!storeBuffer.checkConflict((currentInstruction!.addressOffset! +
                currentInstruction!.operand2Val)
            .round()) &&
        !loadBuffer.checkConflict((currentInstruction!.addressOffset! +
                currentInstruction!.operand2Val)
            .round())) {
      if (storeBuffer.allocate(_currentInstruction!)) {
        freeStation();
      }
    }
  }

  void issueLoad() {
    if (!storeBuffer.checkConflict(
        (currentInstruction!.addressOffset! + currentInstruction!.operand2Val)
            .round())) {
      if (loadBuffer.allocate(_currentInstruction!)) {
        freeStation();
      }
    }
  }

  @override
  void freeStation() {
    super.freeStation();

    address = null;
  }

  void onClockTick() {
    checkReady();
    if (ready) {
      issue();
    }
  }

  bool checkType(instruction.InstructionType t) {
    return (t == instruction.InstructionType.load ||
        t == instruction.InstructionType.store);
  }
}

class AluReservationElement extends ReservationStationElement {
  AluReservationElement(super.ID, super.registers);

  @override
  void checkReady() {
    if (_currentInstruction != null) {
      _ready = _currentInstruction!.operand1ID == null &&
          _currentInstruction!.operand2ID == null;
    }
  }

  @override
  void getData() {
    Tuple2<double, String?> res = registers.getRegister(
        _currentInstruction!.operand1Reg!, listenFirstOperand);
    _currentInstruction!.operand1Val = res.item1;
    _currentInstruction!.operand1ID = res.item2;
    res = registers.getRegister(
        _currentInstruction!.operand2Reg!, listenSecondOperand);
    _currentInstruction!.operand2Val = res.item1;
    _currentInstruction!.operand2ID = res.item2;
    registers.waitOn(_currentInstruction!.target!, ID, addDataListener);
  }
}

abstract class MemoryOperationElement extends ReservationStationElement {
  double? address;

  MemoryOperationElement(super.ID, super.registers);
}

class LoadReservationElement extends MemoryOperationElement {
  LoadReservationElement(super.ID, super.registers);

  @override
  void checkReady() {
    _ready = true;
  }

  @override
  void getData() {
    registers.waitOn(_currentInstruction!.target!, ID, addDataListener);
  }
}

class StoreReservationElement extends MemoryOperationElement {
  StoreReservationElement(super.ID, super.registers);

  @override
  void checkReady() {
    if (_currentInstruction != null) {
      _ready = _currentInstruction!.operand1ID == null;
    }
  }

  @override
  void getData() {
    Tuple2<double, String?> res = registers.getRegister(
        _currentInstruction!.operand1Reg!, listenFirstOperand);
    _currentInstruction!.operand1Val = res.item1;
    _currentInstruction!.operand1ID = res.item2;
  }
}

class ReservationStation {
  operation_station.OperationStation functionalUnit;
  instruction.InstructionType type;
  late List<ReservationStationElement> stations;

  RegisterFile registers;
  int IDCounter = 0;
  ReservationStation.add(
      {int size = 3,
      int funitSize = 3,
      int funitDelay = 5,
      required this.registers})
      : stations = List<ReservationStationElement>.filled(
            size, addStationFill(registers)),
        functionalUnit = operation_station.OperationStation.add(
            size: funitSize, delay: funitDelay),
        type = instruction.InstructionType.add {
    fillListAdd(registers);
  }

  ReservationStation.mult(
      {int size = 3,
      int funitSize = 3,
      int funitDelay = 5,
      required this.registers})
      : stations = List<ReservationStationElement>.filled(
            size, multStationFill(registers)),
        functionalUnit = operation_station.OperationStation.mult(
            size: funitSize, delay: funitDelay),
        type = instruction.InstructionType.mult {
    fillListMult(registers);
  }

  ReservationStation._load(
      {int size = 3, required this.functionalUnit, required this.registers})
      : stations = List<ReservationStationElement>.empty(),
        type = instruction.InstructionType.load;

  ReservationStation._store(
      {int size = 3, required this.functionalUnit, required this.registers})
      : stations = List<ReservationStationElement>.empty(),
        type = instruction.InstructionType.store;

  @override
  String toString() {
    String s = '';
    for (ReservationStationElement e in stations) {
      s += e.toString();
      s += '\n';
    }
    s += '............';
    return s;
  }

  static ReservationStationElement addStationFill(RegisterFile r) {
    return AluReservationElement('A', r);
  }

  static ReservationStationElement multStationFill(RegisterFile r) {
    return AluReservationElement('M', r);
  }

  void fillListAdd(r) {
    List<ReservationStationElement> l = <ReservationStationElement>[];
    for (ReservationStationElement e in stations) {
      l.add(AluReservationElement('A$IDCounter', r));
      IDCounter++;
    }
    stations = l;
  }

  void fillListMult(r) {
    List<ReservationStationElement> l = <ReservationStationElement>[];
    for (ReservationStationElement e in stations) {
      l.add(AluReservationElement('M$IDCounter', r));
      IDCounter++;
    }
    stations = l;
  }

  void fillListDiv(r) {
    List<ReservationStationElement> l = <ReservationStationElement>[];
    for (ReservationStationElement e in stations) {
      l.add(AluReservationElement('D$IDCounter', r));
      IDCounter++;
    }
    stations = l;
  }

  static ReservationStationElement divStationFill(RegisterFile r) {
    return AluReservationElement('D', r);
  }

  void execReady(int clockCycle) {
    for (int i = 0; i < stations.length; i += i-- - i) {
      if (stations[i].ready && stations[i].operating == false) {
        if (functionalUnit.hasFreeStation()) {
          if (functionalUnit.allocate(stations[i], stations[i].ID)) {
            stations[i]._currentInstruction!.startOperationCycle = clockCycle;
            stations[i]._currentInstruction!.endOperationCycle =
                clockCycle + functionalUnit.delay - 1;
            stations[i]._currentInstruction!.writeBackOperationCycle =
                clockCycle + functionalUnit.delay;
            stations[i].operating = true;
          }
        }
      }
    }
  }

  void checkReady() {
    for (int i = 0; i < stations.length; i += i-- - i) {
      if (stations[i].busy) {
        stations[i].checkReady();
      }
    }
  }

  bool isEmpty() {
    for (int i = 0; i < stations.length; i += i-- - i) {
      if (stations[i].busy) {
        return false;
      }
    }
    return true;
  }

  void onClockTick(int clockCycle) {
    execReady(clockCycle);
    functionalUnit.onClockTick();
    checkReady();
  }

  bool allocate(instruction.Instruction i) {
    if (!checkType(i.type)) return false;
    for (ReservationStationElement e in stations) {
      if (!e._busy) {
        e.allocate(i);
        return true;
      }
    }
    return false;
  }

  bool checkType(instruction.InstructionType t) {
    return ((type == instruction.InstructionType.mult &&
            (t == instruction.InstructionType.div ||
                t == instruction.InstructionType.mult)) ||
        (type == instruction.InstructionType.add &&
            (t == instruction.InstructionType.add ||
                t == instruction.InstructionType.sub)));
  }
}

class MemoryBuffer extends ReservationStation {
  List<MemoryOperationElement> real_stations;

  MemoryBuffer.load(
      {int size = 3, required super.functionalUnit, required super.registers})
      : real_stations = List<MemoryOperationElement>.filled(
            size, loadStationFill(registers)),
        super._load(size: size) {
    fillListLoad(registers);
  }
  MemoryBuffer.store(
      {int size = 3, required super.functionalUnit, required super.registers})
      : real_stations = List<MemoryOperationElement>.filled(
            size, storeStationFill(registers)),
        super._store(size: size) {
    fillListStore(registers);
  }

  static MemoryOperationElement loadStationFill(RegisterFile r) {
    return LoadReservationElement('L$ReservationStation.IDCounter', r);
  }

  void fillListLoad(r) {
    List<MemoryOperationElement> l = <MemoryOperationElement>[];
    for (MemoryOperationElement e in real_stations) {
      l.add(LoadReservationElement('L$IDCounter', r));
      IDCounter++;
    }
    real_stations = l;
  }

  void fillListStore(r) {
    List<MemoryOperationElement> l = <MemoryOperationElement>[];
    for (MemoryOperationElement e in real_stations) {
      l.add(StoreReservationElement('S$IDCounter', r));
      IDCounter++;
    }
    real_stations = l;
  }

  static MemoryOperationElement storeStationFill(RegisterFile r) {
    return StoreReservationElement('S$ReservationStation.IDCounter', r);
  }

  @override
  void execReady(int clockCycle) {
    for (int i = 0; i < real_stations.length; i += i-- - i) {
      if (real_stations[i].ready && !real_stations[i].operating) {
        if (functionalUnit.allocate(real_stations[i], real_stations[i].ID)) {
          real_stations[i]._currentInstruction!.startOperationCycle =
              clockCycle;
          real_stations[i]._currentInstruction!.endOperationCycle =
              clockCycle + functionalUnit.delay - 1;
          real_stations[i]._currentInstruction!.writeBackOperationCycle =
              clockCycle + functionalUnit.delay;

          real_stations[i].operating = true;
          break;
        }
      }
    }
  }

  bool checkConflict(int c_address) {
    for (MemoryOperationElement e in real_stations) {
      if (e._busy) {
        if ((e.currentInstruction!.operand2Val +
                e.currentInstruction!.addressOffset!) ==
            c_address) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  bool allocate(instruction.Instruction i) {
    if (i.type != type) return false;
    for (MemoryOperationElement e in real_stations) {
      if (!e._busy) {
        e.allocate(i);
        return true;
      }
    }
    return false;
  }

  @override
  String toString() {
    String s = '';

    for (MemoryOperationElement e in real_stations) {
      s += e.toString();
      s += '\n';
    }
    s += '............';
    return s;
  }

  @override
  void checkReady() {
    for (int i = 0; i < real_stations.length; i += i-- - i) {
      if (real_stations[i].busy) {
        real_stations[i].checkReady();
      }
    }
  }

  @override
  bool isEmpty() {
    for (int i = 0; i < real_stations.length; i += i-- - i) {
      if (real_stations[i].busy) {
        return false;
      }
    }
    return true;
  }

  @override
  void onClockTick(int clockCycle) {
    execReady(clockCycle);
    // do not judge
    // very very very important that to call the clock tick of the store before the load
    //very very very important
    if (type == instruction.InstructionType.load) {
      functionalUnit.onClockTick();
    }
    checkReady();
  }
}
