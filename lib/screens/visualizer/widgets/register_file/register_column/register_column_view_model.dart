import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/providers/registers_providers.dart';
import 'package:tomasulo_viz/models/register.dart';

class RegisterColumnViewModel extends ChangeNotifier {
  RegisterColumnViewModel({required this.register});
  final Register register;

  static final provider =
      ChangeNotifierProvider.family<RegisterColumnViewModel, String>((ref, id) {
    final register = ref.watch(registerProvider(id));
    return RegisterColumnViewModel(register: register);
  });
}
