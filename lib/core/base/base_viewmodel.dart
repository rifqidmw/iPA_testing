import 'dart:async';

import 'package:base_flutter/presentation/common/state_rendrer/state_renderer_imp.dart';
import 'package:rxdart/subjects.dart';

abstract class BaseViewModel extends BaseViewModelInputs implements BaseViewModelOutputs {
  final StreamController<FlowState> _flowStateController  = BehaviorSubject<FlowState>();
  @override
  void dispose() {
    _flowStateController.close();
  }

  @override
  Sink get stateInput => _flowStateController.sink;

  @override
  Stream<FlowState> get stateOutput =>_flowStateController.stream.map((FlowState) => FlowState);

}

abstract class BaseViewModelInputs{
  Sink get stateInput;
  void start();
  void dispose();
}

abstract class BaseViewModelOutputs{
  Stream<FlowState> get stateOutput;
}
