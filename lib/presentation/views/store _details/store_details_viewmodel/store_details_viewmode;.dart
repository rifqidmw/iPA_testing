import 'dart:async';
import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:base_flutter/domain/models/models.dart';
import 'package:base_flutter/domain/usecase/store_details_usecase.dart';
import 'package:base_flutter/core/base/base_viewmodel.dart';
import 'package:base_flutter/presentation/common/state_rendrer/state_renderer_imp.dart';
import 'package:base_flutter/presentation/common/state_rendrer/state_rendrer.dart';
import 'package:base_flutter/presentation/resources/strings_manager.dart';
import 'package:rxdart/subjects.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements InputStoreDetailsViewModel, OutputStoreDetailsViewModel {
  final StreamController _storeDetailsViewModel =
      BehaviorSubject<StoreDetails>();
  StoreDetailsUSeCase _storeDetailsUSeCase;

  StoreDetailsViewModel(this._storeDetailsUSeCase);

  @override
  void start() {
    getStoreDetails();
  }

  @override
  void dispose() {
    _storeDetailsViewModel.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsViewModel.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsViewModel.stream.map((storeDetails) => storeDetails);

  @override
  getStoreDetails() async {
    stateInput.add(LoadingState(
        stateType: RendrerStateType.fullErrorState,
        message: AppStrings.loadingMessage.tr(),
        title: AppStrings.loading.tr()));

    (await _storeDetailsUSeCase.execute(Void)).fold((failure) {
      stateInput.add(ErrorState(
        stateRendererType: RendrerStateType.fullErrorState,
        message: failure.message,
      ));
    }, // to dismiss the dialogs I have used content state as the extension dismiss before building the content
        (storeDetailsObject) {
      inputStoreDetails.add(StoreDetails(
          about: storeDetailsObject.about,
          title: storeDetailsObject.title,
          services: storeDetailsObject.services,
          image: storeDetailsObject.image,
          details: storeDetailsObject.details));
      stateInput.add(ContentState());
    });
  }
}

abstract class InputStoreDetailsViewModel {
  Sink get inputStoreDetails;
  getStoreDetails();
}

abstract class OutputStoreDetailsViewModel {
  Stream<StoreDetails> get outputStoreDetails;
}
