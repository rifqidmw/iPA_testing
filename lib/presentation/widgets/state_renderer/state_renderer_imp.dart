import 'package:base_flutter/core/utils/functions.dart';
import 'package:base_flutter/presentation/resources/constants_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/presentation/widgets/state_renderer/state_rendrer.dart';
import 'package:base_flutter/presentation/resources/strings_manager.dart';

abstract class FlowState {
  RendrerStateType getStateType();
  String getMessage();
  String getTitle();
}

class LoadingState implements FlowState {
  RendrerStateType stateType;
  String message;
  String title;
  LoadingState(
      {this.message = AppStrings.loading,
      required this.stateType,
      required this.title});

  @override
  String getMessage() => message;

  @override
  RendrerStateType getStateType() => stateType;

  @override
  String getTitle() => title;
}

// error state (POPUP,FULL SCREEN)
class ErrorState extends FlowState {
  RendrerStateType stateRendererType;
  String message;
  String title = getString(AppStrings.error);

  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message;

  @override
  RendrerStateType getStateType() => stateRendererType;

  @override
  String getTitle() => title;
}

// content state

class ContentState extends FlowState {
  ContentState();
  String title = '';

  @override
  String getMessage() => AppConstants.empty;

  @override
  RendrerStateType getStateType() => RendrerStateType.contentState;

  @override
  String getTitle() => title;
}

// EMPTY STATE

class EmptyState extends FlowState {
  String message;
  String title = getString(AppStrings.empty);

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  RendrerStateType getStateType() => RendrerStateType.fullEmptyState;

  @override
  String getTitle() => title;
}

class SuccessState extends FlowState {
  String message;
  RendrerStateType stateType;
  String title = getString(AppStrings.success);

  SuccessState(
      {required this.title, required this.message, required this.stateType});

  @override
  String getMessage() => message;

  @override
  RendrerStateType getStateType() => stateType;

  @override
  String getTitle() => title;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateType() == RendrerStateType.popupLoadingState) {
            showPopUp(context, getStateType(), getMessage(), getTitle());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateType: getStateType(),
                title: getTitle(),
                message: getMessage(),
                retryFunctionRenderer: retryActionFunction);
          }
        }
      case ErrorState:
        dismissDialog(context);
        {
          if (getStateType() == RendrerStateType.popupErorrState) {
            showPopUp(context, getStateType(), getMessage(), getTitle());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateType: getStateType(),
                title: getTitle(),
                message: getMessage(),
                retryFunctionRenderer: retryActionFunction);
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          dismissDialog(context);
          return StateRenderer(
              stateType: getStateType(),
              title: getTitle(),
              message: getMessage(),
              retryFunctionRenderer: () {});
        }
      case SuccessState:
        {
          dismissDialog(context);
          if (getStateType() == RendrerStateType.popupSuccessState) {
            showPopUp(context, RendrerStateType.popupSuccessState, getMessage(),
                getTitle());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateType: RendrerStateType.fullSuccessState,
                title: getTitle(),
                message: getMessage(),
                retryFunctionRenderer: () {});
          }
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopUp(BuildContext context, RendrerStateType stateType, String message,
      String title) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateType: stateType,
            title: title,
            message: message,
            retryFunctionRenderer: () {}),
      ),
    );
  }
}
