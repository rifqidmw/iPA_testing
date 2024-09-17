import 'dart:async';
import 'dart:ffi';

import 'package:base_flutter/core/utils/functions.dart';
import 'package:base_flutter/domain/models/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:base_flutter/domain/usecase/home_usecase.dart';
import 'package:base_flutter/core/base/base_viewmodel.dart';
import 'package:base_flutter/presentation/resources/strings_manager.dart';
import 'package:rxdart/subjects.dart';

import '../../widgets/state_renderer/state_renderer_imp.dart';
import '../../widgets/state_renderer/state_rendrer.dart';

class HomeViewModel extends BaseViewModel
    implements InputHomeViewModel, OutputHomeViewModel {
  StreamController listProductStreamController =
      BehaviorSubject<List<ProductModel>>();

  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);
  @override
  void start() {
    _getProducts();
  }

  @override
  void dispose() {
    listProductStreamController.close();
    super.dispose();
  }

  _getProducts() async {
    stateInput.add(LoadingState(
        stateType: RendrerStateType.fullErrorState,
        message: getString(AppStrings.loadingMessage),
        title: getString(AppStrings.loading)));

    (await _homeUseCase.execute(Void)).fold((failure) {
      stateInput.add(ErrorState(
        stateRendererType: RendrerStateType.fullErrorState,
        message: failure.message,
      ));
    }, (data) {
      inputListProduct.add(data);
      stateInput.add(ContentState());
    });
  }

  @override
  Stream<List<ProductModel>> get outputListProduct =>
      listProductStreamController.stream.map((listProduct) => listProduct);

  @override
  Sink get inputListProduct => listProductStreamController.sink;
}

abstract class InputHomeViewModel {
  Sink get inputListProduct;
}

abstract class OutputHomeViewModel {
  Stream<List<ProductModel>> get outputListProduct;
}
