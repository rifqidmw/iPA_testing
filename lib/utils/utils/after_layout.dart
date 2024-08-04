import 'package:base_project_mvvm_provider/utils/utils/common.dart';
import 'package:flutter/material.dart';

/// Callback after build widget is rendered
@Deprecated('Use afterBuildCreated() instead')
mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    makeNullable(WidgetsBinding.instance)!
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);

  @override
  void dispose() {
    super.dispose();
  }
}
