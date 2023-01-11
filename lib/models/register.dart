import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class Register extends ChangeNotifier {
  double value = 0;
  String? opID;
  Function(Function(double, String))? addDataListener;

  @override
  String toString() {
    return ('$value,$opID');
  }

  Tuple2<double, String?> getRegister(Function(double, String) listner) {
    if (opID != null) {
      addDataListener!(listner);
    }
    return Tuple2(value, opID);
  }

  void waitOn(String id, Function(Function(double, String)) addListener) {
    opID = id;
    addListener(listen);
    this.addDataListener = addListener;
  }

  void listen(double data, String id) {
    if (opID == id) {
      value = data;
      opID = null;
      addDataListener = null;
      notifyListeners();
    }
  }
}

class RegisterFile {
  HashMap<String, Register> registers = HashMap<String, Register>();

  RegisterFile() {
    for (int i = 0; i < 10; i += i-- - i) {
      registers.putIfAbsent('R$i', () => Register());
    }
    for (int i = 0; i < 10; i += i-- - i) {
      registers.putIfAbsent('F$i', () => Register());
    }
  }

  Tuple2<double, String?> getRegister(
      String regName, Function(double, String) f) {
    return registers[regName]!.getRegister(f);
  }

  void waitOn(String regName, String id,
      Function(Function(double, String)) addListener) {
    registers[regName]!.waitOn(id, addListener);
  }

  @override
  String toString() {
    String s = "Register file \n";
    s += registers.toString();
    return s;
  }
}

// Use the setter method for x.
