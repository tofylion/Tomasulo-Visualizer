import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomasulo_viz/models/providers/reservation_stations_providers.dart';
import 'package:tomasulo_viz/models/reservation_station.dart';

class ReservationStationElementViewModel extends ChangeNotifier {
  ReservationStationElementViewModel({required this.element});
  final ReservationStationElement element;

  static final provider =
      ChangeNotifierProvider.family<ReservationStationElementViewModel, String>(
          (ref, id) {
    final element = ref.watch(reservationStationElementProvider(id));

    return ReservationStationElementViewModel(element: element);
  });
}
