import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/register.dart';

final registerFileProvider = Provider<RegisterFile>((ref) => RegisterFile());

final registerProvider =
    ChangeNotifierProvider.family<Register, String>((ref, name) {
  return ref.read(registerFileProvider).registers[name]!;
});
