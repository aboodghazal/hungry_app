import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'slider_type_enum.dart';
import 'slider_var_state.dart';

class SliderVarCubit extends Cubit<SliderVarState> {
  SliderVarCubit() : super(SliderVarInitState());

  static SliderVarCubit get(BuildContext context) => BlocProvider.of(context);
  Map<SliderTypeEnum, int> currentSliderIndex = {};
  void changeSliderIndex({
    required int value,
    required SliderTypeEnum type,
  }) {
    currentSliderIndex[type] = value;
    emit(SliderVarChangeSliderIndexState());
  }
}
