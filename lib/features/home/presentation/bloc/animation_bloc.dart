import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationCubit extends Cubit<double> {
  AnimationCubit() : super(0);
    void startRotation() {
    Stream.periodic(const  Duration(milliseconds: 16), (i) => (i * 0.01) % (2 * pi))
        .listen((angle) => emit(angle));
  }
}
