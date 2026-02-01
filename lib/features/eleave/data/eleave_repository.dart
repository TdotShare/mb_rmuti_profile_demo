import 'package:flutter_riverpod/flutter_riverpod.dart';

class EleaveRepository {
  final Ref _ref;
  EleaveRepository(this._ref);
}

// -------------------

final eleaveRepositoryProvider = Provider(
  (ref) => EleaveRepository(ref),
);
